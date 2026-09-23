# Companio — Implementation Plan

## 1. Current architecture

No Companio project exists. The workspace contains unrelated Python/JS projects and a fleet platform (Truxify). This is a greenfield build.

## 2. Existing functionality

None for this product.

## 3. Missing functionality

Everything — see the phased plan below.

## 4. Technical risks

- Low-connectivity regions of Northeast India → offline-first is mandatory.
- Elderly + low technical literacy UX → simple navigation, large targets, no negative feedback.
- Slow dev machine / C: has 16 GB free → keep toolchain lean; avoid heavy packages.
- Voice and media features need per-device fallbacks.

## 5. Proposed architecture

Clean layers, local-first:

```
Presentation (widgets / screens / riverpod providers)
      -> Domain services (garden, adaptive, sos, sync rules)
      -> Data (drift + sqlite, repositories, remote API interface)
      -> Sync engine (local queue, idempotent upload)
```

State management: Riverpod (flutter_riverpod) — testable, scalable, no giant StatefulWidgets.
Local DB: Drift + SQLite (sqlite3). Cross-platform, type-safe, offline.

## 6. Folder structure

```
companio/
  lib/
    core/theme, constants, routing, errors, utilities, localization
    data/local (drift tables + dao), remote (api interface), models,
         repositories, sync
    domain/entities, repository interfaces, services (garden, adaptive, sos, activity engine)
    features/onboarding, home, garden, activities, memories, reminders, sos, caregiver, profile, region, voice
    shared/widgets (design system components)
  assets/ (illustrations, sample imagery, sample audio)
  test/unit, test/widget, test/integration
```

## 7. Required dependencies

flutter_riverpod, drift, drift_flutter, path_provider, path, intl,
flutter_localizations, connectivity_plus, flutter_tts, url_launcher,
uuid, collection. Dev: drift_dev, build_runner, flutter_test, mocktail.

## 8. Design system

Warm garden palette (cream `#FAF6EF`, deep green `#3E6B4A`, gentle green
`#A8C69F`, terracotta `#C96F4A`, warm yellow `#E8B84B`). Large typography,
generous spacing, 8pt grid, reusable components (LargeActionButton,
EmergencyButton, cards, section headers, empty/loading/offline states).

## 9. Data model

Users, patient/caregiver profiles, emergency contacts, activities, daily
activity assignment, attempts, memories (photo/voice/text/place), garden +
elements, reminders, notifications, SOS incidents + contact attempts,
sync queue, preferences, adaptive profile, location memories.

## 10. Offline synchronization

Every mutable operation writes locally and enqueues a SyncQueueItem
(idempotency key, status). On connectivity restore + periodic/retry timer,
sync engine uploads pending items, marks synced, downloads caregiver
updates, resolves conflicts last-write-wins by timestamp. Patient data is
never lost because connectivity is poor.

## 11. Feature phases

P1 Foundation (architecture, theme, DB, models, sync scaffold, navigation)
P2 Core patient experience (onboarding, home, garden, daily activity, mystery memory, memory rescue, activities incl. kitchen/shopping)
P3 Personalization (family memories, photo/voice uploads, preferences, adaptive engine)
P4 Caregiver + safety (caregiver dashboard, SOS + escalation, reminders, notifications)
P5 Intelligence/polish (voice prompts, en/hi localization, region map, tests, docs)

## 12. Testing strategy

- Unit: garden progression, adaptive engine, memory unlock, sync queue,
  SOS escalation, reminder scheduling.
- Widget: home, garden, SOS, patient shell.
- Manual offline scenarios documented in docs/offline-testing.md