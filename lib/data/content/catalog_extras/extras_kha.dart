import '../../../domain/entities/activity_content.dart';

/// Khasi (kha) catalog content overrides. Fields not listed fall back to the
/// English content automatically. Core terms corroborated against xobdo.org.
const Map<String, ActivityContent> extrasKha = {
  'kitchen_chai': ActivityContent(
    steps: [
      'Tiew ia ka um',
      'Theh tam ia ka sla sha',
      'Theh tam ia ka dud',
      'Theh tam ia ka shini',
      'Ther bad theh ia sha ka pela',
    ],
    hint: 'Nyngkong ka um, bakhatduh ka shini.',
  ),
  'kitchen_breakfast': ActivityContent(
    steps: [
      'Piah ia ka krei',
      'To ia ka ruti',
      'Phang ia ka pylleng',
      'Ai ia ha ka shaphrang',
    ],
    hint: 'Kiei kiei baroh la ther hadien ba ai ia ka jingbam.',
  ),
  'shop_bread_milk': ActivityContent(
    products: [
      Product(id: 'milk', label: 'Ka dud', price: 27, emoji: '🥛'),
      Product(id: 'bread', label: 'U ruti', price: 30, emoji: '🍞'),
      Product(id: 'eggs', label: 'Pylleng (6)', price: 42, emoji: '🥚'),
      Product(id: 'biscuit', label: 'Biskut', price: 15, emoji: '🍪'),
      Product(id: 'tea', label: 'U sla sha', price: 55, emoji: '🍵'),
      Product(id: 'rice', label: 'Khaw (1 kg)', price: 80, emoji: '🍚'),
    ],
    hint: 'Ka dud bad ka ruti tang hapdeng ₹100.',
  ),
  'shop_vegetables': ActivityContent(
    products: [
      Product(id: 'potato', label: 'Phan', price: 25, emoji: '🥔'),
      Product(id: 'onion', label: 'Piat', price: 30, emoji: '🧅'),
      Product(id: 'tomato', label: 'Sohsaw', price: 20, emoji: '🍅'),
      Product(id: 'ginger', label: 'Sying', price: 12, emoji: '🫚'),
    ],
    hint: 'Phan + piat = ₹55.',
  ),
  'rec_kitchen_item': ActivityContent(
    variants: [
      '🍵 Ka pela sha',
      '🧺 Ka khoh shriew',
      '🍚 Ka khoh khaw',
      '🧊 Ka stern',
    ],
    correctLabel: '🧺 Ka khoh shriew',
    hint: 'Ngi sah ia ki jingthaw na ka bazar hangne.',
  ),
  'rec_currency_20': ActivityContent(
    hint: 'Ka ruti la die ha ₹30, kane ka shim ia ki ar-divishi jong ka. Kane ka don ka soti ba jam.',
  ),
  'match_festival_food': ActivityContent(
    pairs: [
      MatchPair(left: '🪔 Ka Diwali', right: 'Ka ladu'),
      MatchPair(left: '🎨 Ka Holi', right: 'Ka gulal'),
      MatchPair(left: '🌾 Ka Bihu', right: 'Ka pitha'),
      MatchPair(left: '✨ Ka Eid', right: 'Ka sheer turma'),
    ],
    hint: 'Ka ladu ka dei na ka Diwali.',
  ),
  'match_object_use': ActivityContent(
    pairs: [
      MatchPair(left: '🌂 Ka maiphi', right: 'Ka thap'),
      MatchPair(left: '🌡️ Ka thermos', right: 'Ka sha ba sut'),
      MatchPair(left: '🪭 Ka snam', right: 'Ka por sha ba jan'),
      MatchPair(left: '🧯 Ka lamp', right: 'Ba duh elektrik'),
    ],
    hint: 'Ha ka por thap, phin kwah ia ka.',
  ),
  'seq_morning_routine': ActivityContent(
    steps: [
      'Kheh ia ki shniuh',
      'Piah ia ka khmat',
      'Bam ia ka jingbam syngkai',
      'Dih ia ka sha',
    ],
    hint: 'Ka sha ka wan kunta kaba bud ia ka jingbam.',
  ),
  'seq_route_guwahati': ActivityContent(
    steps: [
      'Ioh noh na ka ïing',
      'Lait iaid sha ka lynti',
      'Shah ha ka bas',
      'Shah noh ha ka bazar',
    ],
    hint: 'Ka jingiaid ka sdang na ka ïing.',
  ),
  'asso_region_products': ActivityContent(
    variants: [
      '☕ Ki sla sha',
      '🏖️ Ka nong hapdeng um',
      '🏜️ Ka ri ba khiah',
      '❄️ Ki lum kabahhap',
    ],
    correctLabel: '☕ Ki sla sha',
    hint: 'Ki lum jong ka Assam ki long ha ka sla khia.',
  ),
  'asso_harvest_food': ActivityContent(
    variants: [
      '🥭 Ka sohpieng',
      '🍌 Ka soh rien',
      '🍊 Ka soh tur',
      '🌰 Ka soh kokonat',
    ],
    correctLabel: '🥭 Ka sohpieng',
    hint: 'U syiem ka jingphalat, ka ja bad ka myntheng.',
  ),
  'attn_find_vegetable': ActivityContent(
    variants: ['🥔 Ka phan', '🌶️ Ka soh-mynken', '🥕 Ka kajor', '🧅 Ka piat'],
    correctLabel: '🥕 Ka kajor',
    hint: 'Ka ka soti rud bad ki khun hop ki ieit ia ka.',
  ),
  'recall_family_song': ActivityContent(
    variants: [
      '🎶 Ka rngai Bihu',
      '🎶 Ka bhajan',
      '🎶 Ka rngai ban san',
      '🎶 Ka rngai film',
    ],
    correctLabel: '🎶 Ka rngai Bihu',
    hint: 'Ha ka por Bihu, ki nongkynti ki ia im noh.',
  ),
  'pairs_market_fruits': ActivityContent(
    variants: ['🥭 Sohjew', '🍌 Kait', '🍊 Sohriew', '🍎 Kteng'],
    hint: 'Wad ia ka para kaba ia shim ha ki soh.',
  ),
  'pairs_kitchen_things': ActivityContent(
    variants: ['🍶 Ketill', '🪭 Shurapher', '🧺 Shayong', '🍲 Pyientha'],
    hint: 'Wad ia ka para ha ki jaiñjuh.',
  ),
};
