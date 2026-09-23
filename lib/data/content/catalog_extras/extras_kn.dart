import '../../../domain/entities/activity_content.dart';

/// Kannada (kn) catalog content overrides. Fields not listed fall back to the
/// English content automatically.
const Map<String, ActivityContent> extrasKn = {
  'kitchen_chai': ActivityContent(
    steps: [
      'ನೀರು ಕುದಿಸಿ',
      'ಚಹಾ ಎಲೆ ಹಾಕಿ',
      'ಹಾಲು ಹಾಕಿ',
      'ಸಕ್ಕರೆ ಹಾಕಿ',
      'ಗಾಳಿಸಿ ಕಪ್ಗೆ ಹಾಕಿ',
    ],
    hint: 'ಮೊದಲು ನೀರು, ಕೊನೆಯಲ್ಲಿ ಸಕ್ಕರೆ.',
  ),
  'kitchen_breakfast': ActivityContent(
    steps: [
      'ಬಾಣಲೆ ತೊಳೆಯಿರಿ',
      'ಬ್ರೆಡ್ ಟೋಸ್ಟ್ ಮಾಡಿ',
      'ಮೊಟ್ಟೆ ಬೇಯಿಸಿ',
      'ಪ್ಲೇಟ್ನಲ್ಲಿ ಬಡಿಸಿ',
    ],
    hint: 'ಅಡುಗೆ ಮೊದಲು ಎಲ್ಲವೂ ಸ್ವಚ್ಛ.',
  ),
  'shop_bread_milk': ActivityContent(
    products: [
      Product(id: 'milk', label: 'ಹಾಲಿನ ಪ್ಯಾಕೆಟ್', price: 27, emoji: '🥛'),
      Product(id: 'bread', label: 'ಬ್ರೆಡ್', price: 30, emoji: '🍞'),
      Product(id: 'eggs', label: 'ಮೊಟ್ಟೆ (6)', price: 42, emoji: '🥚'),
      Product(id: 'biscuit', label: 'ಬಿಸ್ಕತ್ತು', price: 15, emoji: '🍪'),
      Product(id: 'tea', label: 'ಚಹಾ ಎಲೆ', price: 55, emoji: '🍵'),
      Product(id: 'rice', label: 'ಅಕ್ಕಿ (1 ಕೆಜಿ)', price: 80, emoji: '🍚'),
    ],
    hint: 'ಹಾಲು ಮತ್ತು ಬ್ರೆಡ್ ಎರಡೂ ₹100 ಒಳಗೆ.',
  ),
  'shop_vegetables': ActivityContent(
    products: [
      Product(id: 'potato', label: 'ಆಲೂಗಡ್ಡೆ', price: 25, emoji: '🥔'),
      Product(id: 'onion', label: 'ಈರುಳ್ಳಿ', price: 30, emoji: '🧅'),
      Product(id: 'tomato', label: 'ಟೊಮೇಟೊ', price: 20, emoji: '🍅'),
      Product(id: 'ginger', label: 'ಶುಂಠಿ', price: 12, emoji: '🫚'),
    ],
    hint: 'ಆಲೂಗಡ್ಡೆ + ಈರುಳ್ಳಿ = ₹55.',
  ),
  'rec_kitchen_item': ActivityContent(
    variants: [
      '🍵 ಚಹಾ ಕಪ್',
      '🧺 ಬಿದಿರು ಬುಟ್ಟಿ',
      '🍚 ಅನ್ನದ ಪಾತ್ರೆ',
      '🧊 ಮಂಜುಗಡ್ಡೆ ಪೆಟ್ಟಿಗೆ',
    ],
    correctLabel: '🧺 ಬಿದಿರು ಬುಟ್ಟಿ',
    hint: 'ಸಂತೆಯಿಂದ ಸಾಮಾನು ಇದರಲ್ಲಿ ಮನೆಗೆ ತರುತ್ತೇವೆ.',
  ),
  'rec_currency_20': ActivityContent(
    hint: 'ಒಂದು ಬ್ರೆಡ್ ಬೆಲೆ ಸುಮಾರು ₹30, ಇದರಲ್ಲಿ ಅದರ ಮೂರರಲ್ಲಿ ಎರಡು ಭಾಗ ಬರುತ್ತದೆ. ಇದರಲ್ಲಿ ಬಣ್ಣದ ನೋಟುಗಳಿವೆ.',
  ),
  'match_festival_food': ActivityContent(
    pairs: [
      MatchPair(left: '🪔 ದೀಪಾವಳಿ', right: 'ಸಿಹಿ ಲಡ್ಡು'),
      MatchPair(left: '🎨 ಹೋಳಿ', right: 'ಬಣ್ಣದ ಗುಲಾಲ್'),
      MatchPair(left: '🌾 ಬಿಹು', right: 'ಪಿಠಾ'),
      MatchPair(left: '✨ ಈದ್', right: 'ಶೀರ್ ಖುರ್ಮಾ'),
    ],
    hint: 'ದೀಪದ ಹಬ್ಬಕ್ಕೆ ಲಡ್ಡು.',
  ),
  'match_object_use': ActivityContent(
    pairs: [
      MatchPair(left: '🌂 ಕೊಡೆ', right: 'ಮಳೆ'),
      MatchPair(left: '🌡️ ಥರ್ಮಸ್', right: 'ಬಿಸಿ ಚಹಾ'),
      MatchPair(left: '🪭 ಕೈ ಬೀಸಣಿಗೆ', right: 'ಬೇಸಿಗೆ'),
      MatchPair(left: '🧯 ಸೀಮೆಎಣ್ಣೆ ದೀಪ', right: 'ಕರೆಂಟ್ ಇಲ್ಲ'),
    ],
    hint: 'ಮಳೆಗಾಲದಲ್ಲಿ ಇದು ನೆನಪಾಗುತ್ತದೆ.',
  ),
  'seq_morning_routine': ActivityContent(
    steps: ['ಹಲ್ಲುಜ್ಜಿ', 'ಮುಖ ತೊಳೆದು', 'ತಿಂಡಿ ತಿನ್ನಿ', 'ಚಹಾ ಕುಡಿಯಿರಿ'],
    hint: 'ತಿಂದ ನಂತರ ಚಹಾ.',
  ),
  'seq_route_guwahati': ActivityContent(
    steps: [
      'ಮನೆಯಿಂದ ಹೊರಡಿ',
      'ರಸ್ತೆವರೆಗೆ ನಡೆಯಿರಿ',
      'ಬಸ್ ಹತ್ತಿ',
      'ಸಂತೆಯಲ್ಲಿ ಇಳಿಯಿರಿ',
    ],
    hint: 'ಪ್ರಯಾಣ ಮನೆಯಿಂದ ಪ್ರಾರಂಭ.',
  ),
  'asso_region_products': ActivityContent(
    variants: [
      '☕ ಚಹಾ ತೋಟಗಳು',
      '🏖️ ಸಮುದ್ರ ತೀರ',
      '🏜️ ಮರಳಿನ ದಿಣ್ಣೆ',
      '❄️ ಹಿಮದ ಶಿಖರಗಳು',
    ],
    correctLabel: '☕ ಚಹಾ ತೋಟಗಳು',
    hint: 'ಅಸ್ಸಾಂ ಬೆಟ್ಟಗಳು ಹಸಿರು ಚಹಾ ತೋಟಗಳಿಗೆ ಪ್ರಸಿದ್ಧ.',
  ),
  'asso_harvest_food': ActivityContent(
    variants: ['🥭 ಮಾವು', '🍌 ಬಾಳೆಹಣ್ಣು', '🍊 ಕಿತ್ತಳೆ', '🌰 ತೆಂಗಿನಕಾಯಿ'],
    correctLabel: '🥭 ಮಾವು',
    hint: 'ಬೇಸಿಗೆಯ ರಾಜ ಹಣ್ಣು, ಹಳದಿ ಮತ್ತು ಸಿಹಿ.',
  ),
  'attn_find_vegetable': ActivityContent(
    variants: ['🥔 ಆಲೂಗಡ್ಡೆ', '🌶️ ಮೆಣಸಿನಕಾಯಿ', '🥕 ಕ್ಯಾರೆಟ್', '🧅 ಈರುಳ್ಳಿ'],
    correctLabel: '🥕 ಕ್ಯಾರೆಟ್',
    hint: 'ಇದು ಕಿತ್ತಳೆ ಬಣ್ಣ, ಮೊಲಕ್ಕೆ ತುಂಬಾ ಇಷ್ಟ.',
  ),
  'recall_family_song': ActivityContent(
    variants: ['🎶 ಬಿಹು ಹಾಡು', '🎶 ಭಜನೆ', '🎶 ಜೋಗುಳ', '🎶 ಚಿತ್ರದ ಹಾಡು'],
    correctLabel: '🎶 ಬಿಹು ಹಾಡು',
    hint: 'ವಸಂತ ಹಬ್ಬದಲ್ಲಿ ನರ್ತಕರು ಇದಕ್ಕೆ ನೃತ್ಯ ಮಾಡುತ್ತಾರೆ.',
  ),
  'pairs_market_fruits': ActivityContent(
    variants: ['🥭 ಮಾವು', '🍌 ಬಾಳೆಹಣ್ಣು', '🍊 ಕಿತ್ತಳೆ', '🍎 ಸೇಬು'],
    hint: 'ಒಂದೇ ರೀತಿಯ ಎರಡು ಹಣ್ಣುಗಳನ್ನು ಹುಡುಕಿ.',
  ),
  'pairs_kitchen_things': ActivityContent(
    variants: ['🍶 ಕೆಟ್ಲ್', '🪭 ಕೈ ಬೀಸಣಿಗೆ', '🧺 ಬುಟ್ಟಿ', '🍲 ಬಟ್ಟಲು'],
    hint: 'ಒಂದೇ ರೀತಿಯ ಎರಡು ವಸ್ತುಗಳನ್ನು ಹುಡುಕಿ.',
  ),
};
