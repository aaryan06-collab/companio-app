import '../../../domain/entities/activity_content.dart';

/// Manipuri (mni) catalog content overrides. Fields not listed fall back to
/// the English content automatically. Core terms corroborated against xobdo.org.
const Map<String, ActivityContent> extrasMni = {
  'kitchen_chai': ActivityContent(
    steps: [
      'ইসিং সাংগৎলো',
      'চা হুমায় থৌরো',
      'সংগোম থৌরো',
      'চিনি থৌরো',
      'খাকথগা কপদা থৌরো',
    ],
    hint: 'হৌরক্পদা ইসিং, অরুবদা চিনি।',
  ),
  'kitchen_breakfast': ActivityContent(
    steps: [
      'থেংনোকথক ফস্বি',
      'ব্রেড টোস্ট তৌরো',
      'য়েরুম সাংগৎলো',
      'প্লেটদা থৌরো',
    ],
    hint: 'চাক ওইকী মহুৎ অমা খুদক তাগাদুনা থৌরো।',
  ),
  'shop_bread_milk': ActivityContent(
    products: [
      Product(id: 'milk', label: 'সংগোমগি প্যাকেট', price: 27, emoji: '🥛'),
      Product(id: 'bread', label: 'ব্রেড', price: 30, emoji: '🍞'),
      Product(id: 'eggs', label: 'য়েরুম (৬)', price: 42, emoji: '🥚'),
      Product(id: 'biscuit', label: 'বিস্কুট', price: 15, emoji: '🍪'),
      Product(id: 'tea', label: 'চা হুমায়', price: 55, emoji: '🍵'),
      Product(id: 'rice', label: 'চেং (১ কিলো)', price: 80, emoji: '🍚'),
    ],
    hint: 'সংগোম অমসুং ব্রেড ₹১০০ খঙহন্না চাংলো।',
  ),
  'shop_vegetables': ActivityContent(
    products: [
      Product(id: 'potato', label: 'আলু', price: 25, emoji: '🥔'),
      Product(id: 'onion', label: 'তিলহৌ', price: 30, emoji: '🧅'),
      Product(id: 'tomato', label: 'খমেন অশিংবা', price: 20, emoji: '🍅'),
      Product(id: 'ginger', label: 'শিং', price: 12, emoji: '🫚'),
    ],
    hint: 'আলু + তিলহৌ = ₹৫৫।',
  ),
  'rec_kitchen_item': ActivityContent(
    variants: [
      '🍵 চা খায়ু',
      '🧺 থেকনাং থাবু',
      '🍚 চেংগি খায়ু',
      '🧊 উশির বাকস',
    ],
    correctLabel: '🧺 থেকনাং থাবু',
    hint: 'নুংগী লাদু লৈরেবশিং থাবুদা চাংলো।',
  ),
  'rec_currency_20': ActivityContent(
    hint: 'অমা ব্রেডগি মামল ₹৩০ খঙহন্না, মসিদা করি? মসি শিকনা তাৎপরে। মসিদা নুসানা অঙঙবা নোট লৈ।',
  ),
  'match_festival_food': ActivityContent(
    pairs: [
      MatchPair(left: '🪔 দিওয়ালী', right: 'নুংগৎবা লাডু'),
      MatchPair(left: '🎨 হোলী', right: 'নুসানমী গুলাল'),
      MatchPair(left: '🌾 য়াওচেং', right: 'পিঠা'),
      MatchPair(left: '✨ ঈদ', right: 'সীর খুরমা'),
    ],
    hint: 'লাডু মসি মায়োল তুমদা ওইরো।',
  ),
  'match_object_use': ActivityContent(
    pairs: [
      MatchPair(left: '🌂 থুসং', right: 'নোঙ'),
      MatchPair(left: '🌡️ থার্মস', right: 'সাঙীবা চা'),
      MatchPair(left: '🪭 মসঙ খৌ', right: 'নুংইসদা সাঙৎ'),
      MatchPair(left: '🧯 কেরোসিন ল্যাম্প', right: 'বিদ্যুৎ হন্দা'),
    ],
    hint: 'নোঙ উৎপা লৈতনবা ফজলহন্না নাইরো।',
  ),
  'seq_morning_routine': ActivityContent(
    steps: ['য়াকথায় চা-ইয়ো', 'অপাঙ থাবী', 'চাক চায়ো', 'চা থুরু'],
    hint: 'চাক ল্যরবা মতুংদা চা থুরু।',
  ),
  'seq_route_guwahati': ActivityContent(
    steps: ['য়ুমদগী থোকলো', 'লঁঙদা লাকলো', 'বাসদা চেকলো', 'বাজারদা থিতীয়ো'],
    hint: 'শুরু য়ুমদগী।',
  ),
  'asso_region_products': ActivityContent(
    variants: [
      '☕ চা খোংজং',
      '🏖️ সমুদ্রগী নাপগী খোংয়া',
      '🏜️ নুমিত লেক্পা সবু',
      '❄️ উশিরগী খলক',
    ],
    correctLabel: '☕ চা খোংজং',
    hint: 'অসমগী খোংজংয়শিং চা খোংজংগীদা নুংশিখনবনি।',
  ),
  'asso_harvest_food': ActivityContent(
    variants: ['🥭 হৈনৌ', '🍌 নুম্বী', '🍊 কমলা', '🌰 নারিকোল'],
    correctLabel: '🥭 হৈনৌ',
    hint: 'নুংইগী নুংশীযবা ফল, হাউয়বা অমসুং নুংশীগুদা।',
  ),
  'attn_find_vegetable': ActivityContent(
    variants: ['🥔 আলু', '🌶️ মৈরীক', '🥕 কংএস', '🧅 তিলহৌ'],
    correctLabel: '🥕 কংএস',
    hint: 'মসি হাউয়াবা অমসুং এন্থুম উশিংয়দা মসিমা নুংই।',
  ),
  'recall_family_song': ActivityContent(
    variants: ['🎶 য়াওচেংগী ঈশৈ', '🎶 ভজন', '🎶 নুপী ঈশৈ', '🎶 ফিল্মগী ঈশৈ'],
    correctLabel: '🎶 য়াওচেংগী ঈশৈ',
    hint: 'য়াওচেং গুরুমদা জাগয়শিং মসিমা জাগো।',
  ),
  'pairs_market_fruits': ActivityContent(
    variants: ['🥭 সম', '🍌 থংজঙ', '🍊 মৈরু', '🍎 থগেক'],
    hint: 'অমুক তুম্মা করগা জেরা ফল থোক।',
  ),
  'pairs_kitchen_things': ActivityContent(
    variants: ['🍶 কেত্লি', '🪭 পন্থনাগী মীরেং', '🧺 খুম্লুম', '🍲 ঠুম'],
    hint: 'অমুক তুম্মা করগা জেরা খোযশিং থোক।',
  ),
};
