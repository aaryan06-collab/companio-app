import '../../../domain/entities/activity_content.dart';

/// Assamese (as) catalog content overrides. Fields not listed fall back to
/// the English content automatically.
const Map<String, ActivityContent> extrasAs = {
  'kitchen_chai': ActivityContent(
    steps: [
      'পানী উতলাওক',
      'চাহপাত যোগ কৰক',
      'গাখীৰ যোগ কৰক',
      'চেনি যোগ কৰক',
      'ছেকি কাপত ঢালি দিয়ক',
    ],
    hint: 'আগেয়ে পানী, শেষত চেনি।',
  ),
  'kitchen_breakfast': ActivityContent(
    steps: [
      'কৰাহীখন ধুই লওক',
      'ব্ৰেড ততা কৰক',
      'কণী সিজাওক',
      'প্লেটত বাঢ়ি দিয়ক',
    ],
    hint: 'ৰন্ধাৰ আগত সকলো পৰিষ্কাৰ কৰা হয়।',
  ),
  'shop_bread_milk': ActivityContent(
    products: [
      Product(id: 'milk', label: 'গাখীৰৰ পেকেট', price: 27, emoji: '🥛'),
      Product(id: 'bread', label: 'পাউৰুটি', price: 30, emoji: '🍞'),
      Product(id: 'eggs', label: 'কণী (৬)', price: 42, emoji: '🥚'),
      Product(id: 'biscuit', label: 'বিস্কুট', price: 15, emoji: '🍪'),
      Product(id: 'tea', label: 'চাহপাত', price: 55, emoji: '🍵'),
      Product(id: 'rice', label: 'চাউল (১ কিলো)', price: 80, emoji: '🍚'),
    ],
    hint: 'গাখীৰ আৰু পাউৰুটি লগতে ₹100 তকৈ কমতে পোৱা যায়।',
  ),
  'shop_vegetables': ActivityContent(
    products: [
      Product(id: 'potato', label: 'আলু', price: 25, emoji: '🥔'),
      Product(id: 'onion', label: 'পিয়াঁজ', price: 30, emoji: '🧅'),
      Product(id: 'tomato', label: 'বিলাহী', price: 20, emoji: '🍅'),
      Product(id: 'ginger', label: 'আদা', price: 12, emoji: '🫚'),
    ],
    hint: 'আলু + পিয়াঁজ = ₹55।',
  ),
  'rec_kitchen_item': ActivityContent(
    variants: [
      '🍵 চাহৰ বাটি',
      '🧺 বাঁহৰ টুকুৰী',
      '🍚 চাউলৰ বাটি',
      '🧊 বৰফৰ বাকছ',
    ],
    correctLabel: '🧺 বাঁহৰ টুকুৰী',
    hint: 'বজাৰৰ পৰা বস্তু এইটোতে ঘৰলৈ লৈ আহোঁ।',
  ),
  'rec_currency_20': ActivityContent(
    hint: 'এখন পাউৰুটিৰ দাম প্ৰায় ₹30, ইয়াৰে তাৰ দু-তৃতীয়াংশ দিব পাৰি। ইয়াত ৰঙীন নোট আছে।',
  ),
  'match_festival_food': ActivityContent(
    pairs: [
      MatchPair(left: '🪔 দীপাৱলী', right: 'মিঠা লাড়ু'),
      MatchPair(left: '🎨 হোলী', right: 'ৰঙীন গুলাল'),
      MatchPair(left: '🌾 বিহু', right: 'পিঠা'),
      MatchPair(left: '✨ ঈদ', right: 'শ্বিৰ খুৰমা'),
    ],
    hint: 'দীপাৱলী, পোহৰৰ উৎসৱৰ বাবে লাড়ু।',
  ),
  'match_object_use': ActivityContent(
    pairs: [
      MatchPair(left: '🌂 ছাতি', right: 'বৰষুণ'),
      MatchPair(left: '🌡️ থাৰ্মাছ', right: 'গৰম চাহ'),
      MatchPair(left: '🪭 হাতপাখা', right: 'গৰমি'),
      MatchPair(left: '🧯 কেৰ’চিন লেম্প', right: 'বিজুলী নাই'),
    ],
    hint: 'বৰষুণৰ দিনত ইয়াৰ কথা মনত পৰে।',
  ),
  'seq_morning_routine': ActivityContent(
    steps: ['দাঁত মাজক', 'মুখ ধুওক', 'জলপান খাওক', 'চাহ খাওক'],
    hint: 'খোৱাৰ পিছত চাহ খাওক।',
  ),
  'seq_route_guwahati': ActivityContent(
    steps: ['ঘৰৰ পৰা ওলাওক', 'ৰাস্তালৈ যাওক', 'বাছত উঠক', 'বজাৰত নামক'],
    hint: 'যাত্ৰা ঘৰৰ পৰাই আৰম্ভ হয়।',
  ),
  'asso_region_products': ActivityContent(
    variants: [
      '☕ চাহ বাগান',
      '🏖️ সাগৰীয় বালিচহৰ',
      '🏜️ বালিময় পাহি',
      '❄️ বৰফৰ চূড়া',
    ],
    correctLabel: '☕ চাহ বাগান',
    hint: 'অসমৰ পাহাৰবোৰ সেউজীয়া চাহ বাগানৰ বাবে বিখ্যাত।',
  ),
  'asso_harvest_food': ActivityContent(
    variants: ['🥭 আম', '🍌 কল', '🍊 কমলা', '🌰 নাৰিকল'],
    correctLabel: '🥭 আম',
    hint: 'গৰমীৰ ৰজা ফল, হালধীয়া আৰু মিঠা।',
  ),
  'attn_find_vegetable': ActivityContent(
    variants: ['🥔 আলু', '🌶️ জালুক', '🥕 গাজৰ', '🧅 পিয়াঁজ'],
    correctLabel: '🥕 গাজৰ',
    hint: 'এইটো কমলা বৰণীয়া আৰু খৰগোছে ইয়াক ভাল পায়।',
  ),
  'recall_family_song': ActivityContent(
    variants: ['🎶 বিহু গীত', '🎶 ভজন', '🎶 লুলাবাই', '🎶 চলচ্চিত্ৰৰ গীত'],
    correctLabel: '🎶 বিহু গীত',
    hint: 'বসন্ত উৎসৱত নাচনীয়ে ইয়াত নাচে।',
  ),
  'pairs_market_fruits': ActivityContent(
    variants: ['🥭 আম', '🍌 কল', '🍊 কমলা', '🍎 আপেল'],
    hint: 'একেবাৰে একে দুটা ফল বিচাৰক।',
  ),
  'pairs_kitchen_things': ActivityContent(
    variants: ['🍶 কেটলী', '🪭 হাত পাখা', '🧺 টুকুৰী', '🍲 বাটি'],
    hint: 'একেবাৰে একে দুটা বস্তু বিচাৰক।',
  ),
};
