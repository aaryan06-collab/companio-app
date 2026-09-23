import '../../../domain/entities/activity_content.dart';

/// Garo (grt) catalog content overrides. Fields not listed fall back to the
/// English content automatically. Core terms corroborated against xobdo.org/Glosbe.
const Map<String, ActivityContent> extrasGrt = {
  'kitchen_chai': ActivityContent(
    steps: [
      'Chiko silata',
      'Cha bipang raba',
      'Dut raba',
      'Chini raba',
      'Cha ko chipang kap-o raba',
    ],
    hint: 'Baggio chi, jotdon chini.',
  ),
  'kitchen_breakfast': ActivityContent(
    steps: [
      'Kokkaniko da-ota',
      'Bredko tost ka-ata',
      'Bichi urata',
      'Palet-o gananiko on-a',
    ],
    hint: 'Ka-aona skanga jikoniko da-ota.',
  ),
  'shop_bread_milk': ActivityContent(
    products: [
      Product(id: 'milk', label: 'Dutni subanga', price: 27, emoji: '🥛'),
      Product(id: 'bread', label: 'Bred', price: 30, emoji: '🍞'),
      Product(id: 'eggs', label: 'Bichi (6)', price: 42, emoji: '🥚'),
      Product(id: 'biscuit', label: 'Biskut', price: 15, emoji: '🍪'),
      Product(id: 'tea', label: 'Cha bipang', price: 55, emoji: '🍵'),
      Product(id: 'rice', label: 'Me (1 kg)', price: 80, emoji: '🍚'),
    ],
    hint: 'Dut aro bred choda ₹100 baksa donga.',
  ),
  'shop_vegetables': ActivityContent(
    products: [
      Product(id: 'potato', label: 'Alu', price: 25, emoji: '🥔'),
      Product(id: 'onion', label: 'Piaj', price: 30, emoji: '🧅'),
      Product(id: 'tomato', label: 'Tomato', price: 20, emoji: '🍅'),
      Product(id: 'ginger', label: 'Aching', price: 12, emoji: '🫚'),
    ],
    hint: 'Alu + piaj = ₹55.',
  ),
  'rec_kitchen_item': ActivityContent(
    variants: ['🍵 Cha kap', '🧺 Wan jakra', '🍚 Mesni bati', '🧊 Ska bari'],
    correctLabel: '🧺 Wan jakra',
    hint: 'Bazaroni gimin jikoniko nokoni raba.',
  ),
  'rec_currency_20': ActivityContent(
    hint: 'Bredna dam ₹30, indake iachi jigirgipako mingni gimiko on·a. Iachi ranga sikai donga.',
  ),
  'match_festival_food': ActivityContent(
    pairs: [
      MatchPair(left: '🪔 Diwali', right: 'Mitinga lado'),
      MatchPair(left: '🎨 Holi', right: 'Ranga gulo'),
      MatchPair(left: '🌾 Bihu', right: 'Pitha'),
      MatchPair(left: '✨ Eid', right: 'Siir khurma'),
    ],
    hint: 'Lado Diwalini gimin.',
  ),
  'match_object_use': ActivityContent(
    pairs: [
      MatchPair(left: '🌂 Ske', right: 'Mikka'),
      MatchPair(left: '🌡️ Termos', right: 'Mitinga cha'),
      MatchPair(left: '🪭 Apang', right: 'Rugil bari'),
      MatchPair(left: '🧯 Lamp', right: 'Bijli ningtuga'),
    ],
    hint: 'Mikka rangko on·aoba ia ka gita nanga.',
  ),
  'seq_morning_routine': ActivityContent(
    steps: ['Wagamako gima-e', 'Mikkangko da-ota', 'Chipa bama', 'Cha ringna'],
    hint: 'Cha ringkam bamani ja·mano.',
  ),
  'seq_route_guwahati': ActivityContent(
    steps: [
      'Nokoni agana',
      'Alaona gakiangna',
      'Busona songna',
      'Bazaro ringku·a',
    ],
    hint: 'Mikoni nokoni skanga.',
  ),
  'asso_region_products': ActivityContent(
    variants: [
      '☕ Cha bal',
      '🏖️ Samudrani dini',
      '🏜️ Jakdipani dongram',
      '❄️ Skani biling',
    ],
    correctLabel: '☕ Cha bal',
    hint: 'Assamni biling cha balni gimin sakki ong·a.',
  ),
  'asso_harvest_food': ActivityContent(
    variants: ['🥭 Te·gatchu', '🍌 Terik', '🍊 Komila', '🌰 Narikel'],
    correctLabel: '🥭 Te·gatchu',
    hint: 'Gamrangni raja, ranga aro mitinga.',
  ),
  'attn_find_vegetable': ActivityContent(
    variants: ['🥔 Alu', '🌶️ Chili', '🥕 Garot', '🧅 Piaj'],
    correctLabel: '🥕 Garot',
    hint: 'Ia a·ba ranga aro rabha nangna napgen.',
  ),
  'recall_family_song': ActivityContent(
    variants: ['🎶 Bihu ringani', '🎶 Bajan', '🎶 Lullabi', '🎶 Film ringani'],
    correctLabel: '🎶 Bihu ringani',
    hint: 'Bihu cholmungo dangia manderang ia gita ringa.',
  ),
  'pairs_market_fruits': ActivityContent(
    variants: ['🥭 Mambi', '🍌 Kol', '🍊 Songkol', '🍎 A-ppel'],
    hint: 'Gipakkobeko bi·sapko nika.',
  ),
  'pairs_kitchen_things': ActivityContent(
    variants: ['🍶 Ketili', '🪭 Ka·tok', '🧺 Kalga', '🍲 Batai'],
    hint: 'Gipakkobeko gisimko nika.',
  ),
};
