import '../../../domain/entities/activity_content.dart';

/// Mizo (lus) catalog content overrides. Fields not listed fall back to the
/// English content automatically. Core terms corroborated against xobdo.org/Glosbe.
/// Residual loans: 'Thermos' (trademark), 'Vur bawks'/'Bajan'/'Lullabi' (UNVERIFIED spellings).
const Map<String, ActivityContent> extrasLus = {
  'kitchen_chai': ActivityContent(
    steps: [
      'Tui bo rawh',
      'Thingpui hnah telh rawh',
      'Hnute telh rawh',
      'Chithlum telh rawh',
      'Khak chhuak a, cup-ah bun rawh',
    ],
    hint: 'Hmasa tui, hnuhnung chithlum.',
  ),
  'kitchen_breakfast': ActivityContent(
    steps: [
      'Ril hlawh rawh',
      'Changei tawt rawh',
      'Artui bo rawh',
      'Plate-ah bun rawh',
    ],
    hint: 'Chaw ei hmain engkim a tlan fai a ngai.',
  ),
  'shop_bread_milk': ActivityContent(
    products: [
      Product(id: 'milk', label: 'Hnute ba', price: 27, emoji: '🥛'),
      Product(id: 'bread', label: 'Changei', price: 30, emoji: '🍞'),
      Product(id: 'eggs', label: 'Artui (6)', price: 42, emoji: '🥚'),
      Product(id: 'biscuit', label: 'Biskut', price: 15, emoji: '🍪'),
      Product(id: 'tea', label: 'Thingpui hnah', price: 55, emoji: '🍵'),
      Product(id: 'rice', label: 'Buh (1 kg)', price: 80, emoji: '🍚'),
    ],
    hint: 'Hnute leh changei hi ₹100 aia hniamin a awm.',
  ),
  'shop_vegetables': ActivityContent(
    products: [
      Product(id: 'potato', label: 'Alumal', price: 25, emoji: '🥔'),
      Product(id: 'onion', label: 'Purun', price: 30, emoji: '🧅'),
      Product(id: 'tomato', label: 'Tomato', price: 20, emoji: '🍅'),
      Product(id: 'ginger', label: 'Sawhthing', price: 12, emoji: '🫚'),
    ],
    hint: 'Alumal + what = ₹55.',
  ),
  'rec_kitchen_item': ActivityContent(
    variants: ['🍵 Tib', '🧺 Sangchali', '🍚 Buh tib', '🧊 Vur bawks'],
    correctLabel: '🧺 Sangchali',
    hint: 'Bazar aṭanga thil lo tuah nan kan hman thin.',
  ),
  'rec_currency_20': ActivityContent(
    hint: 'Changei khat man ₹30 a nih chuan, hei hian a chan changa leh a huai; mahse a tlem. Hei ah hian colour nei note a awm.',
  ),
  'match_festival_food': ActivityContent(
    pairs: [
      MatchPair(left: '🪔 Diwali', right: 'Ladu'),
      MatchPair(left: '🎨 Holi', right: 'Gulal'),
      MatchPair(left: '🌾 Bihu', right: 'Pitha'),
      MatchPair(left: '✨ Eid', right: 'Siir khurma'),
    ],
    hint: 'Ladu chu Engbik meitheh starhunah hman thin.',
  ),
  'match_object_use': ActivityContent(
    pairs: [
      MatchPair(left: '🌂 Tinkai', right: 'Ruah'),
      MatchPair(left: '🌡️ Thermos', right: 'Thingpui sa'),
      MatchPair(left: '🪭 Fan', right: 'Nisa chang'),
      MatchPair(left: '🧯 Mawithang', right: 'Electricor bo'),
    ],
    hint: 'Ruah sur hunah hei hi kan hman tlat thin.',
  ),
  'seq_morning_routine': ActivityContent(
    steps: [
      'Ha hliw rawh',
      'Hmel silh rawh',
      'Chaw ei rawh',
      'Thingpui in rawh',
    ],
    hint: 'Eih hnu ah thingpui in thin.',
  ),
  'seq_route_guwahati': ActivityContent(
    steps: [
      'In aṭanga chhuak rawh',
      'Kawngah kal rawh',
      'Bus-a chuang rawh',
      'Bazar-ah thla rawh',
    ],
    hint: 'Chhuakna chu in aṭang a ni.',
  ),
  'asso_region_products': ActivityContent(
    variants: [
      '☕ Thingpui hmun',
      '🏖️ Tui riang leh',
      '🏜️ Desert',
      '❄️ Snow peak-te',
    ],
    correctLabel: '☕ Thingpui hmun',
    hint: 'Assam tlang ah thingpui lo tam tak a awm.',
  ),
  'asso_harvest_food': ActivityContent(
    variants: ['🥭 Theihai', '🍌 Balhla', '🍊 Suh', '🌰 Vaka'],
    correctLabel: '🥭 Theihai',
    hint: 'Theihai a ni, a tui em em.',
  ),
  'attn_find_vegetable': ActivityContent(
    variants: ['🥔 Alumal', '🌶️ Hmarcha', '🥕 Karot', '🧅 Purun'],
    correctLabel: '🥕 Karot',
    hint: 'Hei hi vawng a ni a, rabbit ten an duh em em.',
  ),
  'recall_family_song': ActivityContent(
    variants: ['🎶 Bihu hla', '🎶 Bajan', '🎶 Lullabi', '🎶 Film hla'],
    correctLabel: '🎶 Bihu hla',
    hint: 'Bihu ni-ah hla zaite an zai thin.',
  ),
  'pairs_market_fruits': ActivityContent(
    variants: ['🥭 Thei', '🍌 Pangbal', '🍊 Thei sen', '🍎 Thei hlui'],
    hint: 'Ṭhuhmun chan zel pair zawng rawh.',
  ),
  'pairs_kitchen_things': ActivityContent(
    variants: ['🍶 Khup', '🪭 Chhuhlungkaih', '🧺 Bu', '🍲 Noi'],
    hint: 'A hmun chan ang tak pair zawng rawh.',
  ),
};
