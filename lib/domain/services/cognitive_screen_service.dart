/// The 15 caregiver-answered screening questions about the patient
/// (AD8-style early-warning checklist), referenced by localization key.
const List<String> screeningQuestionKeys = [
  'screenQ01',
  'screenQ02',
  'screenQ03',
  'screenQ04',
  'screenQ05',
  'screenQ06',
  'screenQ07',
  'screenQ08',
  'screenQ09',
  'screenQ10',
  'screenQ11',
  'screenQ12',
  'screenQ13',
  'screenQ14',
  'screenQ15',
];

/// Simple three-band interpretation of a screening total (0..60, higher =
/// better). Heavy "Not sure" / "Very frequently" answers drag the total into
/// the doctor band on purpose.
enum ScreeningBand { fine, watch, doctor }

/// Maximum points per question: 15 questions x 4 points.
const int screeningMaxScore = 15 * 4;

/// Points awarded per answer choice for a single question.
const Map<String, int> screeningAnswerScore = {
  'rarely': 4,
  'sometimes': 3,
  'frequently': 2,
  'veryfrequently': 1,
  'notsure': 0,
};

/// Sums the chosen answers (order values by question key order).
int screeningTotalFor(Map<String, String> answers) {
  var total = 0;
  for (final key in screeningQuestionKeys) {
    final value = answers[key];
    if (value != null) {
      total += screeningAnswerScore[value] ?? 0;
    }
  }
  return total;
}

ScreeningBand screeningBandFor(int score) {
  if (score >= 45) return ScreeningBand.fine;
  if (score >= 30) return ScreeningBand.watch;
  return ScreeningBand.doctor;
}

String screeningStatusKey(ScreeningBand band) => switch (band) {
  ScreeningBand.fine => 'screenStatusGood',
  ScreeningBand.watch => 'screenStatusWatch',
  ScreeningBand.doctor => 'screenStatusDoctor',
};

String screeningEmoji(ScreeningBand band) => switch (band) {
  ScreeningBand.fine => '🌿',
  ScreeningBand.watch => '🌤️',
  ScreeningBand.doctor => '🩺',
};
