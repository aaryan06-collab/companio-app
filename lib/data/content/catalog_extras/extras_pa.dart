import '../../../domain/entities/activity_content.dart';

/// Punjabi (pa) catalog content overrides. Fields not listed fall back to the
/// English content automatically.
const Map<String, ActivityContent> extrasPa = {
  'kitchen_chai': ActivityContent(
    steps: [
      'ਪਾਣੀ ਉਬਾਲੋ',
      'ਚਾਹ ਪੱਤ ਪਾਓ',
      'ਦੁੱਧ ਪਾਓ',
      'ਖੰਡ ਪਾਓ',
      'ਛਾਣ ਕੇ ਕੱਪ ਵਿੱਚ ਪਾਓ',
    ],
    hint: 'ਪਹਿਲਾਂ ਪਾਣੀ, ਆਖਰ ਖੰਡ।',
  ),
  'kitchen_breakfast': ActivityContent(
    steps: ['ਪਤੀਲੀ ਧੋ ਲਓ', 'ਬਰੈੱਡ ਟੋਸਟ ਕਰੋ', 'ਅੰਡੇ ਉਬਾਲੋ', 'ਪਲੇਟ ਵਿੱਚ ਪਰੋਸੋ'],
    hint: 'ਪਕਾਉਣ ਤੋਂ ਪਹਿਲਾਂ ਸਭ ਕੁਝ ਸਾਫ਼।',
  ),
  'shop_bread_milk': ActivityContent(
    products: [
      Product(id: 'milk', label: 'ਦੁੱਧ ਦਾ ਪੈਕੇਟ', price: 27, emoji: '🥛'),
      Product(id: 'bread', label: 'ਬਰੈੱਡ', price: 30, emoji: '🍞'),
      Product(id: 'eggs', label: 'ਅੰਡੇ (੬)', price: 42, emoji: '🥚'),
      Product(id: 'biscuit', label: 'ਬਿਸਕੁਟ', price: 15, emoji: '🍪'),
      Product(id: 'tea', label: 'ਚਾਹ ਪੱਤ', price: 55, emoji: '🍵'),
      Product(id: 'rice', label: 'ਚੌਲ (੧ ਕਿਲੋ)', price: 80, emoji: '🍚'),
    ],
    hint: 'ਦੁੱਧ ਅਤੇ ਬਰੈੱਡ ਦੋਵੇਂ ₹੧੦੦ ਤੋਂ ਘੱਟ।',
  ),
  'shop_vegetables': ActivityContent(
    products: [
      Product(id: 'potato', label: 'ਆਲੂ', price: 25, emoji: '🥔'),
      Product(id: 'onion', label: 'ਪਿਆਜ਼', price: 30, emoji: '🧅'),
      Product(id: 'tomato', label: 'ਟਮਾਟਰ', price: 20, emoji: '🍅'),
      Product(id: 'ginger', label: 'ਅਦਰਕ', price: 12, emoji: '🫚'),
    ],
    hint: 'ਆਲੂ + ਪਿਆਜ਼ = ₹੫੫।',
  ),
  'rec_kitchen_item': ActivityContent(
    variants: [
      '🍵 ਚਾਹ ਦਾ ਕੱਪ',
      '🧺 ਬਾਂਸ ਦੀ ਟੋਕਰੀ',
      '🍚 ਚੌਲ ਦਾ ਕਟੋਰਾ',
      '🧊 ਬਰਫ਼ ਦਾ ਡੱਬਾ',
    ],
    correctLabel: '🧺 ਬਾਂਸ ਦੀ ਟੋਕਰੀ',
    hint: 'ਬਾਜ਼ਾਰ ਤੋਂ ਸਮਾਨ ਇਸ ਵਿੱਚ ਘਰ ਲਿਆਉਂਦੇ ਹਾਂ।',
  ),
  'rec_currency_20': ActivityContent(
    hint: 'ਇੱਕ ਬਰੈੱਡ ਦੀ ਕੀਮਤ ਲਗਭਗ ₹੩੦ ਹੈ, ਇਸ ਵਿੱਚ ਉਸਦਾ ਦੋ-ਤਿਹਾਈ ਸਕਦਾ ਹੈ। ਇਸ ਵਿੱਚ ਰੰਗੀਨ ਨੋਟ ਹਨ।',
  ),
  'match_festival_food': ActivityContent(
    pairs: [
      MatchPair(left: '🪔 ਦੀਵਾਲੀ', right: 'ਮਿੱਠਾ ਲੱਡੂ'),
      MatchPair(left: '🎨 ਹੋਲੀ', right: 'ਰੰਗੀਨ ਗੁਲਾਲ'),
      MatchPair(left: '🌾 ਬਿਹੂ', right: 'ਪੀਠਾ'),
      MatchPair(left: '✨ ਈਦ', right: 'ਸ਼ੀਰ ਖੁਰਮਾ'),
    ],
    hint: 'ਦੀਵਾਲੀ ਲਈ ਲੱਡੂ।',
  ),
  'match_object_use': ActivityContent(
    pairs: [
      MatchPair(left: '🌂 ਛਤਰੀ', right: 'ਮੀਂਹ'),
      MatchPair(left: '🌡️ ਥਰਮਸ', right: 'ਗਰਮ ਚਾਹ'),
      MatchPair(left: '🪭 ਪੱਖਾ', right: 'ਗਰਮੀ'),
      MatchPair(left: '🧯 ਕਿਰੋਸੀਨ ਲਾਲਟੈਣ', right: 'ਬਿਜਲੀ ਗਈ'),
    ],
    hint: 'ਮੀਂਹ ਵਿੱਚ ਇਸਦੀ ਯਾਦ ਆਉਂਦੀ ਹੈ।',
  ),
  'seq_morning_routine': ActivityContent(
    steps: ['ਦੰਦ ਸਾਫ਼ ਕਰੋ', 'ਚਿਹਰਾ ਧੋ ਲਓ', 'ਨਾਸ਼ਤਾ ਕਰੋ', 'ਚਾਹ ਪੀਓ'],
    hint: 'ਖਾਣ ਮਗਰੋਂ ਚਾਹ।',
  ),
  'seq_route_guwahati': ActivityContent(
    steps: ['ਘਰੋਂ ਨਿਕਲੋ', 'ਸੜਕ ਤੱਕ ਚੱਲੋ', 'ਬੱਸ ਚੜ੍ਹੋ', 'ਬਾਜ਼ਾਰ ਵਿੱਚ ਉਤਰੋ'],
    hint: 'ਸਫ਼ਰ ਘਰ ਤੋਂ ਸ਼ੁਰੂ।',
  ),
  'asso_region_products': ActivityContent(
    variants: [
      '☕ ਚਾਹ ਦੇ ਬਾਗ',
      '🏖️ ਸਮੁੰਦਰੀ ਕੰਢਾ',
      '🏜️ ਰੇਤ ਦੇ ਟਿੱਲੇ',
      '❄️ ਬਰਫ਼ ਦੀਆਂ ਚੋਟੀਆਂ',
    ],
    correctLabel: '☕ ਚਾਹ ਦੇ ਬਾਗ',
    hint: 'ਅਸਾਮ ਦੇ ਪਹਾੜ ਹਰੇ ਚਾਹ ਬਾਗਾਂ ਲਈ ਮਸ਼ਹੂਰ।',
  ),
  'asso_harvest_food': ActivityContent(
    variants: ['🥭 ਅੰਬ', '🍌 ਕੇਲਾ', '🍊 ਸੰਤਰਾ', '🌰 ਨਾਰੀਅਲ'],
    correctLabel: '🥭 ਅੰਬ',
    hint: 'ਗਰਮੀ ਦਾ ਰਾਜਾ ਫਲ, ਪੀਲਾ ਅਤੇ ਮਿੱਠਾ।',
  ),
  'attn_find_vegetable': ActivityContent(
    variants: ['🥔 ਆਲੂ', '🌶️ ਮਿਰਚ', '🥕 ਗਾਜਰ', '🧅 ਪਿਆਜ਼'],
    correctLabel: '🥕 ਗਾਜਰ',
    hint: 'ਇਹ ਸੰਤਰੀ ਹੈ ਅਤੇ ਖਰਗੋਸ਼ ਨੂੰ ਬਹੁਤ ਪਸੰਦ ਹੈ।',
  ),
  'recall_family_song': ActivityContent(
    variants: ['🎶 ਬਿਹੂ ਗੀਤ', '🎶 ਭਜਨ', '🎶 ਲੋਰੀ', '🎶 ਫ਼ਿਲਮ ਗੀਤ'],
    correctLabel: '🎶 ਬਿਹੂ ਗੀਤ',
    hint: 'ਵਸੰਤ ਤਿਉਹਾਰ ਵਿੱਚ ਨੱਚਣ ਵਾਲੇ ਇਸ ’ਤੇ ਨੱਚਦੇ ਹਨ।',
  ),
  'pairs_market_fruits': ActivityContent(
    variants: ['🥭 ਅੰਬ', '🍌 ਕੇਲਾ', '🍊 ਸੰਤਰਾ', '🍎 ਸੇਬ'],
    hint: 'ਬਿਲਕੁਲ ਇੱਕੋ ਜਿਹੇ ਦੋ ਫਲ ਲੱਭੋ।',
  ),
  'pairs_kitchen_things': ActivityContent(
    variants: ['🍶 ਕੇਤਲੀ', '🪭 ਹੱਥ ਪੱਖਾ', '🧺 ਟੋਕਰੀ', '🍲 ਕਟੋਰਾ'],
    hint: 'ਬਿਲਕੁਲ ਇੱਕੋ ਜਿਹੀਆਂ ਦੋ ਚੀਜ਼ਾਂ ਲੱਭੋ।',
  ),
};
