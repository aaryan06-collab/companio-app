import '../../../domain/entities/activity_content.dart';

/// Urdu (ur) catalog content overrides. Fields not listed fall back to the
/// English content automatically.
const Map<String, ActivityContent> extrasUr = {
  'kitchen_chai': ActivityContent(
    steps: [
      'پانی ابالیں',
      'چائے پتی ڈالیں',
      'دودھ ڈالیں',
      'چینی ڈالیں',
      'چھان کر کپ میں ڈالیں',
    ],
    hint: 'پہلے پانی، آخر میں چینی۔',
  ),
  'kitchen_breakfast': ActivityContent(
    steps: ['پتیلی دھوئیں', 'بریڈ ٹوسٹ کریں', 'انڈے ابالیں', 'پلیٹ میں رکھیں'],
    hint: 'پکانے سے پہلے سب کچھ صاف۔',
  ),
  'shop_bread_milk': ActivityContent(
    products: [
      Product(id: 'milk', label: 'دودھ کا پیکٹ', price: 27, emoji: '🥛'),
      Product(id: 'bread', label: 'بریڈ', price: 30, emoji: '🍞'),
      Product(id: 'eggs', label: 'انڈے (6)', price: 42, emoji: '🥚'),
      Product(id: 'biscuit', label: 'بسکٹ', price: 15, emoji: '🍪'),
      Product(id: 'tea', label: 'چائے پتی', price: 55, emoji: '🍵'),
      Product(id: 'rice', label: 'چاول (1 کلو)', price: 80, emoji: '🍚'),
    ],
    hint: 'دودھ اور بریڈ دونوں ₹100 سے کم۔',
  ),
  'shop_vegetables': ActivityContent(
    products: [
      Product(id: 'potato', label: 'آلو', price: 25, emoji: '🥔'),
      Product(id: 'onion', label: 'پیاز', price: 30, emoji: '🧅'),
      Product(id: 'tomato', label: 'ٹماٹر', price: 20, emoji: '🍅'),
      Product(id: 'ginger', label: 'ادرک', price: 12, emoji: '🫚'),
    ],
    hint: 'آلو + پیاز = ₹55۔',
  ),
  'rec_kitchen_item': ActivityContent(
    variants: [
      '🍵 چائے کا کپ',
      '🧺 بانس کی ٹوکری',
      '🍚 چاول کی کٹوری',
      '🧊 برف کا ڈبہ',
    ],
    correctLabel: '🧺 بانس کی ٹوکری',
    hint: 'بازار سے سامان اسی میں گھر لاتے ہیں۔',
  ),
  'rec_currency_20': ActivityContent(
    hint: 'ایک بریڈ کی قیمت تقریباً ₹30 ہے، اس میں اس کا دو تہائی آ سکتا ہے۔ اس میں رنگین نوٹ ہیں۔',
  ),
  'match_festival_food': ActivityContent(
    pairs: [
      MatchPair(left: '🪔 دیوالی', right: 'مٹھا لڈو'),
      MatchPair(left: '🎨 ہولی', right: 'رنگین گلال'),
      MatchPair(left: '🌾 بیہو', right: 'پیتھا'),
      MatchPair(left: '✨ عید', right: 'شیر خرمہ'),
    ],
    hint: 'دیوالی کے لیے لڈو۔',
  ),
  'match_object_use': ActivityContent(
    pairs: [
      MatchPair(left: '🌂 چھتری', right: 'بارش'),
      MatchPair(left: '🌡️ تھرمس', right: 'گرم چائے'),
      MatchPair(left: '🪭 پنکھا', right: 'گرمی'),
      MatchPair(left: '🧯 کیروسین لالٹین', right: 'بجلی چلی گئی'),
    ],
    hint: 'بارش میں اس کی یاد آتی ہے۔',
  ),
  'seq_morning_routine': ActivityContent(
    steps: ['دانت صاف کریں', 'چہرہ دھوئیں', 'ناشتہ کریں', 'چائے پئیں'],
    hint: 'کھانے کے بعد چائے۔',
  ),
  'seq_route_guwahati': ActivityContent(
    steps: ['گھر سے نکلیں', 'سڑک تک چلیں', 'بس پکڑیں', 'بازار میں اتریں'],
    hint: 'سفر گھر سے شروع ہوتا ہے۔',
  ),
  'asso_region_products': ActivityContent(
    variants: [
      '☕ چائے کے باغات',
      '🏖️ سمندری ساحل',
      '🏜️ ریت کے ٹیلے',
      '❄️ برف کی چوٹیاں',
    ],
    correctLabel: '☕ چائے کے باغات',
    hint: 'آسام کے پہاڑ سبز چائے کے باغات کے لیے مشہور ہیں۔',
  ),
  'asso_harvest_food': ActivityContent(
    variants: ['🥭 آم', '🍌 کیلے', '🍊 سنترا', '🌰 ناریل'],
    correctLabel: '🥭 آم',
    hint: 'گرمی کا بادشاہ پھل، پیلا اور میٹھا۔',
  ),
  'attn_find_vegetable': ActivityContent(
    variants: ['🥔 آلو', '🌶️ مرچ', '🥕 گاجر', '🧅 پیاز'],
    correctLabel: '🥕 گاجر',
    hint: 'یہ نارنجی ہے اور خرگوش کو بہت پسند ہے۔',
  ),
  'recall_family_song': ActivityContent(
    variants: ['🎶 بیہو گیت', '🎶 بھجن', '🎶 لوری', '🎶 فلمی گیت'],
    correctLabel: '🎶 بیہو گیت',
    hint: 'بہار کے تہوار میں رقاص اس پر ناچتے ہیں۔',
  ),
  'pairs_market_fruits': ActivityContent(
    variants: ['🥭 آم', '🍌 کیلا', '🍊 سنترا', '🍎 سیب'],
    hint: 'بالکل ایک جیسے دو پھل ڈھونڈیں۔',
  ),
  'pairs_kitchen_things': ActivityContent(
    variants: ['🍶 کیٹل', '🪭 پنکھا', '🧺 ٹوکری', '🍲 پیالہ'],
    hint: 'بالکل ایک جیسی دو چیزیں ڈھونڈیں۔',
  ),
};
