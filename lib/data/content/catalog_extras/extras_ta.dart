import '../../../domain/entities/activity_content.dart';

/// Tamil (ta) catalog content overrides. Fields not listed fall back to the
/// English content automatically.
const Map<String, ActivityContent> extrasTa = {
  'kitchen_chai': ActivityContent(
    steps: [
      'தண்ணீர் கொதிக்க வை',
      'தேயிலை இலை சேர்',
      'பால் சேர்',
      'சர்க்கரை சேர்',
      'வடிகட்டி கோப்பையில் ஊற்று',
    ],
    hint: 'முதல் தண்ணீர், கடைசியில் சர்க்கரை.',
  ),
  'kitchen_breakfast': ActivityContent(
    steps: [
      'வாணலியைக் கழுவு',
      'பிரெட் டோஸ்ட் செய்',
      'முட்டை கொதிக்க வை',
      'தட்டில் பரிமாறு',
    ],
    hint: 'சமைக்கும் முன் எல்லாம் சுத்தம்.',
  ),
  'shop_bread_milk': ActivityContent(
    products: [
      Product(id: 'milk', label: 'பால் பாக்கெட்', price: 27, emoji: '🥛'),
      Product(id: 'bread', label: 'பிரெட்', price: 30, emoji: '🍞'),
      Product(id: 'eggs', label: 'முட்டை (6)', price: 42, emoji: '🥚'),
      Product(id: 'biscuit', label: 'பிஸ்கட்', price: 15, emoji: '🍪'),
      Product(id: 'tea', label: 'தேயிலை இலை', price: 55, emoji: '🍵'),
      Product(id: 'rice', label: 'அரிசி (1 கிலோ)', price: 80, emoji: '🍚'),
    ],
    hint: 'பால் மற்றும் பிரெட் இணையாக ₹100-க்குள்.',
  ),
  'shop_vegetables': ActivityContent(
    products: [
      Product(id: 'potato', label: 'உருளைக்கிழங்கு', price: 25, emoji: '🥔'),
      Product(id: 'onion', label: 'வெங்காயம்', price: 30, emoji: '🧅'),
      Product(id: 'tomato', label: 'தக்காளி', price: 20, emoji: '🍅'),
      Product(id: 'ginger', label: 'இஞ்சி', price: 12, emoji: '🫚'),
    ],
    hint: 'உருளைக்கிழங்கு + வெங்காயம் = ₹55.',
  ),
  'rec_kitchen_item': ActivityContent(
    variants: [
      '🍵 டீ கோப்பை',
      '🧺 மூங்கில் கூடை',
      '🍚 சோற்றுக் கிண்ணம்',
      '🧊 பனி பெட்டி',
    ],
    correctLabel: '🧺 மூங்கில் கூடை',
    hint: 'சந்தையிலிருந்து பொருட்களை இதில் வீட்டுக்கு எடுத்து வருகிறோம்.',
  ),
  'rec_currency_20': ActivityContent(
    hint: 'ஒரு பிரெட்டின் விலை சுமார் ₹30, இதில் அதன் மூன்றில் இரண்டு பங்கு வரும். இதில் வண்ண நோட்டுகள் உள்ளன.',
  ),
  'match_festival_food': ActivityContent(
    pairs: [
      MatchPair(left: '🪔 தீபாவளி', right: 'இனிப்பு லட்டு'),
      MatchPair(left: '🎨 ஹோலி', right: 'வண்ண குலால்'),
      MatchPair(left: '🌾 பீஹு', right: 'பித்தா'),
      MatchPair(left: '✨ ஈத்', right: 'ஷீர் குர்மா'),
    ],
    hint: 'தீபாவளிக்கு லட்டு.',
  ),
  'match_object_use': ActivityContent(
    pairs: [
      MatchPair(left: '🌂 குடை', right: 'மழை'),
      MatchPair(left: '🌡️ தெர்மோஸ்', right: 'சூடான டீ'),
      MatchPair(left: '🪭 கை விசிறி', right: 'வெயில்'),
      MatchPair(left: '🧯 மண்ணெண்ணெய் விளக்கு', right: 'மின்சாரம் இல்லை'),
    ],
    hint: 'மழைக்காலத்தில் இது நினைவு வரும்.',
  ),
  'seq_morning_routine': ActivityContent(
    steps: ['பற்கள் துலக்கு', 'முகம் கழுவு', 'காலை உணவு சாப்பிடு', 'டீ குடி'],
    hint: 'சாப்பிட்ட பிறகு டீ.',
  ),
  'seq_route_guwahati': ActivityContent(
    steps: [
      'வீட்டிலிருந்து புறப்படு',
      'சாலை வரை நட',
      'பேருந்தில் ஏறு',
      'சந்தையில் இறங்கு',
    ],
    hint: 'பயணம் வீட்டிலிருந்து தொடங்கும்.',
  ),
  'asso_region_products': ActivityContent(
    variants: [
      '☕ தேயிலைத் தோட்டம்',
      '🏖️ கடற்கரை',
      '🏜️ பாலைவன மணல் மேடு',
      '❄️ பனி சிகரம்',
    ],
    correctLabel: '☕ தேயிலைத் தோட்டம்',
    hint: 'அசாமின் மலைகள் பசுமையான தேயிலைத் தோட்டங்களுக்குப் பெயர் பெற்றவை.',
  ),
  'asso_harvest_food': ActivityContent(
    variants: ['🥭 மாம்பழம்', '🍌 வாழைப்பழம்', '🍊 ஆரஞ்சு', '🌰 தேங்காய்'],
    correctLabel: '🥭 மாம்பழம்',
    hint: 'கோடையின் அரசன் பழம், மஞ்சள் மற்றும் இனிப்பு.',
  ),
  'attn_find_vegetable': ActivityContent(
    variants: ['🥔 உருளைக்கிழங்கு', '🌶️ மிளகாய்', '🥕 கேரட்', '🧅 வெங்காயம்'],
    correctLabel: '🥕 கேரட்',
    hint: 'இது ஆரஞ்சு நிறம், முயலுக்கு மிகவும் பிடிக்கும்.',
  ),
  'recall_family_song': ActivityContent(
    variants: ['🎶 பீஹு பாடல்', '🎶 பஜன்', '🎶 தாலாட்டு', '🎶 சினிமா பாடல்'],
    correctLabel: '🎶 பீஹு பாடல்',
    hint: 'வசந்த பண்டிகையில் நடனக்காரர்கள் இதன் மீது நடனமாடுகிறார்கள்.',
  ),
  'pairs_market_fruits': ActivityContent(
    variants: ['🥭 மாம்பழம்', '🍌 வாழைப்பழம்', '🍊 ஆரஞ்சு', '🍎 ஆப்பிள்'],
    hint: 'ஒரே மாதிரியான இரண்டு பழங்களைக் கண்டுபிடியுங்கள்.',
  ),
  'pairs_kitchen_things': ActivityContent(
    variants: ['🍶 கெட்டில்', '🪭 கை விசிறி', '🧺 கூடை', '🍲 கிண்ணம்'],
    hint: 'ஒரே மாதிரியான இரண்டு பொருட்களைக் கண்டுபிடியுங்கள்.',
  ),
};
