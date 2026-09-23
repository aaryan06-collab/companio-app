import '../../../domain/entities/activity_content.dart';

/// Bengali (bn) catalog content overrides. Fields not listed fall back to
/// the English content automatically.
const Map<String, ActivityContent> extrasBn = {
  'kitchen_chai': ActivityContent(
    steps: [
      'পানি ফোটান',
      'চা পাতা দিন',
      'দুধ দিন',
      'চিনি দিন',
      'ছেঁকে কাপে ঢালুন',
    ],
    hint: 'আগে পানি, শেষে চিনি।',
  ),
  'kitchen_breakfast': ActivityContent(
    steps: [
      'করাই ধুয়ে নিন',
      'পাউরুটি টোস্ট করুন',
      'ডিম সিদ্ধ করুন',
      'প্লেটে পরিবেশন করুন',
    ],
    hint: 'রান্নার আগে সবকিছু পরিষ্কার হয়।',
  ),
  'shop_bread_milk': ActivityContent(
    products: [
      Product(id: 'milk', label: 'দুধের প্যাকেট', price: 27, emoji: '🥛'),
      Product(id: 'bread', label: 'পাউরুটি', price: 30, emoji: '🍞'),
      Product(id: 'eggs', label: 'ডিম (৬)', price: 42, emoji: '🥚'),
      Product(id: 'biscuit', label: 'বিস্কুট', price: 15, emoji: '🍪'),
      Product(id: 'tea', label: 'চা পাতা', price: 55, emoji: '🍵'),
      Product(id: 'rice', label: 'চাল (১ কেজি)', price: 80, emoji: '🍚'),
    ],
    hint: 'দুধ আর পাউরুটি মিলিয়ে ₹100-এর মধ্যে থাকে।',
  ),
  'shop_vegetables': ActivityContent(
    products: [
      Product(id: 'potato', label: 'আলু', price: 25, emoji: '🥔'),
      Product(id: 'onion', label: 'পেঁয়াজ', price: 30, emoji: '🧅'),
      Product(id: 'tomato', label: 'টমেটো', price: 20, emoji: '🍅'),
      Product(id: 'ginger', label: 'আদা', price: 12, emoji: '🫚'),
    ],
    hint: 'আলু + পেঁয়াজ = ₹55।',
  ),
  'rec_kitchen_item': ActivityContent(
    variants: [
      '🍵 চায়ের কাপ',
      '🧺 বাঁশের ঝুড়ি',
      '🍚 ভাতের বাটি',
      '🧊 বরফের বাক্স',
    ],
    correctLabel: '🧺 বাঁশের ঝুড়ি',
    hint: 'বাজার থেকে জিনিস এইটেতেই ঘরে আনি।',
  ),
  'rec_currency_20': ActivityContent(
    hint: 'একটি পাউরুটির দাম প্রায় ₹30, এতে তার দুই-তৃতীয়াংশ কেনা যায়। এতে রঙিন নোট আছে।',
  ),
  'match_festival_food': ActivityContent(
    pairs: [
      MatchPair(left: '🪔 দীপাবলী', right: 'মিষ্টি লাড্ডু'),
      MatchPair(left: '🎨 হোলি', right: 'রঙিন গুলাল'),
      MatchPair(left: '🌾 বিহু', right: 'পিঠে'),
      MatchPair(left: '✨ ঈদ', right: 'শির খুরমা'),
    ],
    hint: 'আলোর উৎসবের জন্য লাড্ডু।',
  ),
  'match_object_use': ActivityContent(
    pairs: [
      MatchPair(left: '🌂 ছাতা', right: 'বৃষ্টি'),
      MatchPair(left: '🌡️ থার্মস', right: 'গরম চা'),
      MatchPair(left: '🪭 হাতপাখা', right: 'গরমকাল'),
      MatchPair(left: '🧯 কেরোসিন ল্যাম্প', right: 'বিদ্যুৎ নেই'),
    ],
    hint: 'বর্ষায় এটি মনে পড়ে।',
  ),
  'seq_morning_routine': ActivityContent(
    steps: ['দাঁত মাজুন', 'মুখ ধুয়ে নিন', 'নাশতা করুন', 'চা খান'],
    hint: 'খাওয়ার পরে চা খান।',
  ),
  'seq_route_guwahati': ActivityContent(
    steps: [
      'বাড়ি থেকে বেরুন',
      'রাস্তা পর্যন্ত হাঁটুন',
      'বাসে উঠুন',
      'বাজারে নামুন',
    ],
    hint: 'যাত্রা শুরু হয় বাড়ি থেকে।',
  ),
  'asso_region_products': ActivityContent(
    variants: [
      '☕ চা বাগান',
      '🏖️ সমুদ্র সৈকত',
      '🏜️ মরুভূমির টিলা',
      '❄️ তুষারময় চূড়া',
    ],
    correctLabel: '☕ চা বাগান',
    hint: 'আসামের পাহাড় সবুজ চা বাগানের জন্য বিখ্যাত।',
  ),
  'asso_harvest_food': ActivityContent(
    variants: ['🥭 আম', '🍌 কলা', '🍊 কমলা', '🌰 নারকেল'],
    correctLabel: '🥭 আম',
    hint: 'গ্রীষ্মের রাজা ফল, হলুদ ও মিষ্টি।',
  ),
  'attn_find_vegetable': ActivityContent(
    variants: ['🥔 আলু', '🌶️ ঝাল', '🥕 গাজর', '🧅 পেঁয়াজ'],
    correctLabel: '🥕 গাজর',
    hint: 'এটি কমলা রঙের, খরগোশ খুব ভালোবাসে।',
  ),
  'recall_family_song': ActivityContent(
    variants: ['🎶 বিহু গান', '🎶 ভজন', '🎶 লুলাবাই', '🎶 সিনেমার গান'],
    correctLabel: '🎶 বিহু গান',
    hint: 'বসন্ত উৎসবে নর্তকীরা এর সাথে নাচে।',
  ),
  'pairs_market_fruits': ActivityContent(
    variants: ['🥭 আম', '🍌 কলা', '🍊 কমলা', '🍎 আপেল'],
    hint: 'ঠিক একই রকমের দুটি ফল খুঁজুন।',
  ),
  'pairs_kitchen_things': ActivityContent(
    variants: ['🍶 কেতলি', '🪭 হাত পাখা', '🧺 ঝুড়ি', '🍲 বাটি'],
    hint: 'ঠিক একই রকমের দুটি জিনিস খুঁজুন।',
  ),
};
