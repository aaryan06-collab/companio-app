# Companio

**SIH 2024 · Problem Statement #26003** — AI-based cognitive gaming and memory
assistance platform for elderly dementia patients of the North-Eastern Region
(NER).

A Flutter app (offline-first, 20 languages incl. 10+ NER minority languages)
paired with a FastAPI backend that hosts the adaptive-difficulty ML model and
enables the live two-device demo:

* **Patient phone** — daily cognitive games shipped fully offline
  (memory, attention, kitchen tasks, festival matching, recall), SOS panic
  button, and a pairing code shown in Settings.
* **Caregiver phone** — live SOS alerts, patient AI trend charts (fl_chart),
  model metrics (accuracy / real vs. seeded sessions), and 6-digit pairing-code
  linking to the patient.
* **Backend** — JWT auth, idempotent offline sync (push/pull), SOS inbox
  acknowledgements, analytics aggregation, and a scikit-learn adaptive
  difficulty model with strict retraining gates.

---

## Repository layout

```
companio/
├── lib/                  # Flutter app
│   ├── data/remote/      #   ServerSession store, ServerClient (HTTP), RemoteApi
│   ├── data/local/       #   Drift DB, offline sync queue
│   ├── data/sync/        #   SyncService (RemoteApplier, resilience)
│   ├── app/providers.dart#   Riverpod wiring incl. careRemoteProvider
│   ├── features/         #   caregiver/patient screens
│   └── core/localization #   l10n dictionaries (20 languages)
├── server/               # FastAPI backend
│   ├── app/              #   routers (auth, sync, sos, analytics, difficulty, admin), ml/
│   ├── scripts/          #   seed_demo_activity.py, train_model.py, demo_e2e.py
│   ├── tests/            #   pytest suite (18 tests)
│   └── data/             #   live.db (runtime) + demo.db (seeded training baseline)
└── android/              # INTERNET + cleartext enabled for LAN demo
```

---

# SIH Demo Runbook

Everything below assumes the Flask-side venv is `server/.venv` and Flutter is
available as `flutter` on PATH (see [Toolchain notes](#toolchain-notes)).

## 1. One-time backend setup

```powershell
cd server
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
```

## 2. Seed and train the difficulty model

```powershell
# Seed 1080 demo activity samples and retrain the adaptive-difficulty model.
# The model is only deployed if it clears the gates (>=100 samples, >=2 domains,
# holdout accuracy >= 0.60 AND >= 0.05 ahead of the majority baseline).
.\.venv\Scripts\python.exe scripts\seed_demo_activity.py
.\.venv\Scripts\python.exe scripts\train_model.py
```

Verify the model card:

```powershell
.\.venv\Scripts\python.exe -m uvicorn app.main:app --host 127.0.0.1 --port 8000
# then:
#   GET /admin/model-card  -> deployed, demoSamples=1080, holdoutAccuracy, domains
#   GET /health            -> {status: ok, service: companio, version: 1.0.0}
```

## 3. Automated two-device verification (recommended before the live demo)

Runs a real uvicorn server on a throwaway port with temporary databases and
replays the exact flow the app drives — patient signup → device register →
activity + SOS sync push → caregiver signup → pairing-code link → live SOS
alert → acknowledge → patient pull receives `sos_ack` → caregiver analytics →
adaptive difficulty → idempotent re-push. 14 checks, all must PASS.

```powershell
cd server
.\.venv\Scripts\python.exe scripts\demo_e2e.py
```

Unit suite (same checks plus ML gates and auth edge cases):

```powershell
.\.venv\Scripts\python.exe -m pytest -q   # 18 passed
```

## 4. Live two-phone LAN demo

1. **Find the laptop's LAN IP** (both phones and laptop on the same Wi-Fi):

   ```powershell
   ipconfig   # look for "IPv4 Address" on the active adapter, e.g. 192.168.1.42
   ```

2. **Start the server bound to all interfaces** and keep the window open:

   ```powershell
   cd server
   .\.venv\Scripts\python.exe -m uvicorn app.main:app --host 0.0.0.0 --port 8000
   ```

3. **Build two demo APKs** pointing at that IP (one per connected phone):

   ```powershell
   flutter build apk --debug --dart-define=COMPANIO_API_URL=http://192.168.1.42:8000
   # installs: flutter install (device selectors) or manual adb install
   ```

   Both phones run the *same* APK — the account role decides who is the patient
   and who is the caregiver.

4. **Demo flow** (alternate between the two phones):

   | Step | Phone | Action |
   | --- | --- | --- |
   | 1 | **Patient** | Sign up as *patient* → note the 6-character pairing code in **Settings** |
   | 2 | **Patient** | Play a cognitive game (completing it uploads an activity record) |
   | 3 | **Caregiver** | Sign up as *caregiver* → compare profile → tap **Link to patient** → enter the code |
   | 4 | **Caregiver** | Dashboard shows the linked patient with **AI Trend** chart + model metrics |
   | 5 | **Patient** | Replay a game — note the adaptive difficulty from `GET /difficulty/next` |
   | 6 | **Patient** | Trigger the **SOS** panic button |
   | 7 | **Caregiver** | SOS card turns **LIVE** → tap **Respond** |
   | 8 | **Patient** | SOS shows acknowledged by the caregiver (pulled `sos_ack`) |

   Offline resilience: stop the server and play a game — the queue retains the
   record (`pending`) and uploads it on the next sync tick once the server is
   back.

## 5. Model card / retrain during the demo

```text
GET  /admin/model-card        deployed model stats
POST /admin/retrain           refits on demo.db UNION live.db (needs gate thresholds)
GET  /admin/status            feature & data pipeline status
```

## Environment variables (all optional)

| Variable | Default | Purpose |
| --- | --- | --- |
| `MINDCARE_LIVE_DB` | `server/data/companio.db` | live runtime DB |
| `MINDCARE_TRAIN_DB` | `server/data/demo.db` | seeded training baseline |
| `MINDCARE_MODEL_PATH` | `server/models/difficulty_model.pkl` | trained model artifact |
| `MINDCARE_JWT_SECRET` | dev-only default | HS256 signing key (change in prod) |
| `MINDCARE_JWT_EXPIRY_MINUTES` | `43200` (30 days) | token lifetime |

## Toolchain notes

* Flutter SDK at `C:\dev\flutter`; it may not be on PATH:
  `$env:Path = "C:\dev\flutter\bin;$env:Path"`
* Backend venv: `server\.venv\Scripts\python.exe` (Python 3.12.6)
* `flutter analyze` and `flutter test` are green (17 tests).

## Offline (no-server) mode

Without `COMPANIO_API_URL` the app runs entirely offline via the local Drift
store and `LocalUserApi` — the original per-device demo. Set the dart-define to
route the same binaries through the backend (`RemoteApi`); offline behaviour is
still preserved through the pending-queue retry logic.