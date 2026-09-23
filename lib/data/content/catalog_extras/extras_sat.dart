import '../../../domain/entities/activity_content.dart';

/// Santali (sat) catalog content overrides. Fields not listed fall back to
/// the English content automatically. Core terms corroborated against Glosbe.
const Map<String, ActivityContent> extrasSat = {
  'kitchen_chai': ActivityContent(
    steps: [
      'दाक उमारमे',
      'चा रोड़ जोड़ोमे',
      'तोआ जोड़ोमे',
      'चिनि जोड़ोमे',
      'तनहंसिदा कप रे चोंदोमे',
    ],
    hint: 'पिरी दाक, धुकुल चिनि।',
  ),
  'kitchen_breakfast': ActivityContent(
    steps: [
      'करारी सोड़ेमे',
      'ब्रेड टोस्ट करमे',
      'अंडा उमारेमे',
      'प्लेट रे देमे',
    ],
    hint: 'चहक पृडी सनाम सोदरेमे।',
  ),
  'shop_bread_milk': ActivityContent(
    products: [
      Product(id: 'milk', label: 'तोआ र पैकेट', price: 27, emoji: '🥛'),
      Product(id: 'bread', label: 'ब्रेड', price: 30, emoji: '🍞'),
      Product(id: 'eggs', label: 'अंडा (६)', price: 42, emoji: '🥚'),
      Product(id: 'biscuit', label: 'बिस्कुट', price: 15, emoji: '🍪'),
      Product(id: 'tea', label: 'चा रोड़', price: 55, emoji: '🍵'),
      Product(id: 'rice', label: 'चावले (१ किलो)', price: 80, emoji: '🍚'),
    ],
    hint: 'तोआ अड़ ब्रेड ₹१०० रे रावड़ा।',
  ),
  'shop_vegetables': ActivityContent(
    products: [
      Product(id: 'potato', label: 'आलु', price: 25, emoji: '🥔'),
      Product(id: 'onion', label: 'पियाज', price: 30, emoji: '🧅'),
      Product(id: 'tomato', label: 'टमाटर', price: 20, emoji: '🍅'),
      Product(id: 'ginger', label: 'अदरक', price: 12, emoji: '🫚'),
    ],
    hint: 'आलु + पियाज = ₹५५।',
  ),
  'rec_kitchen_item': ActivityContent(
    variants: ['🍵 चा कप', '🧺 वायम दुरंग', '🍚 चावले कप', '🧊 इसो बाकस'],
    correctLabel: '🧺 वायम दुरंग',
    hint: 'बाजारड़ा दगा सामन ओहन वायम रे में चोเย।',
  ),
  'rec_currency_20': ActivityContent(
    hint: 'ब्रेड र दम ₹३० खान, ओहन रे आर्हांटा चड़e आकं। ओहन रे रंगवा नोट आहे।',
  ),
  'match_festival_food': ActivityContent(
    pairs: [
      MatchPair(left: '🪔 दीवाली', right: 'मिठा लड्डू'),
      MatchPair(left: '🎨 होली', right: 'रंगा गुलाल'),
      MatchPair(left: '🌾 बिहू', right: 'पिठा'),
      MatchPair(left: '✨ ईद', right: 'शीर खुरमा'),
    ],
    hint: 'लड्डू मिथा फुतड़ा परब तेहमाड़ा।',
  ),
  'match_object_use': ActivityContent(
    pairs: [
      MatchPair(left: '🌂 छाता', right: 'चहाक'),
      MatchPair(left: '🌡️ थर्मस', right: 'सड़ो चा'),
      MatchPair(left: '🪭 पसी', right: 'गड़वा सबाह'),
      MatchPair(left: '🧯 केरोसिन लालटेन', right: 'बिजली नेल'),
    ],
    hint: 'चहाक सबाह रे ओहन मे मानजरे।',
  ),
  'seq_morning_routine': ActivityContent(
    steps: ['दाङ सोडेमे', 'मुकड़ सोडेमे', 'आमला चंदेमे', 'चा थुमे'],
    hint: 'जोम नेहड़ा चा थुमे।',
  ),
  'seq_route_guwahati': ActivityContent(
    steps: [
      'ओरड़ा रे निरचन्दरेमे',
      'सड़क ताहे चका रे कदमे',
      'बस रे टेलमे',
      'बाजार रे उतरमे',
    ],
    hint: 'पेरोड़ ओरड़ा रे रोड़।',
  ),
  'asso_region_products': ActivityContent(
    variants: [
      '☕ चा लोहरघाटो',
      '🏖️ समुद्र र बेला',
      '🏜️ दुहू र टोकें',
      '❄️ निनी पिरिया',
    ],
    correctLabel: '☕ चा लोहरघाटो',
    hint: 'असम र पहाड़ चा लोहरघाटो दगा मशहूर आहे।',
  ),
  'asso_harvest_food': ActivityContent(
    variants: ['🥭 उअ', '🍌 कतर', '🍊 कमला', '🌰 नारियल'],
    correctLabel: '🥭 उअ',
    hint: 'गड़वा र राजा फल, भाढ़ा अड़ मिठा।',
  ),
  'attn_find_vegetable': ActivityContent(
    variants: ['🥔 आलु', '🌶️ फरुल', '🥕 गाजर', '🧅 पियाज'],
    correctLabel: '🥕 गाजर',
    hint: 'ओहन नारंगी रंग रे आहे अड़ खरगोश बड़ी मिना।',
  ),
  'recall_family_song': ActivityContent(
    variants: ['🎶 बिहू रेड़', '🎶 भजन', '🎶 धुत घोड़म', '🎶 फिल्म रेड़'],
    correctLabel: '🎶 बिहू रेड़',
    hint: 'फुतड़ा परब रे संगालिंग सेत ओहन रे।',
  ),
  'pairs_market_fruits': ActivityContent(
    variants: ['🥭 হঁড়ি', '🍌 কদলি', '🍊 কমলা', '🍎 সেয়া'],
    hint: 'জোড়া চেতা মেরে মেরে খোজ।',
  ),
  'pairs_kitchen_things': ActivityContent(
    variants: ['🍶 বাটা', '🪭 সারা', '🧺 বুর', '🍲 অবাই'],
    hint: 'জোড়া চেতা বস্তু খোজ।',
  ),
};
