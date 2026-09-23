import '../../../domain/entities/activity_content.dart';

/// Odia (or) catalog content overrides. Fields not listed fall back to the
/// English content automatically.
const Map<String, ActivityContent> extrasOr = {
  'kitchen_chai': ActivityContent(
    steps: [
      'ପାଣି ଫୁଟାନ୍ତୁ',
      'ଚା ପତ୍ର ଦିଅନ୍ତୁ',
      'କ୍ଷୀର ଦିଅନ୍ତୁ',
      'ଚିନି ଦିଅନ୍ତୁ',
      'ଛାଣି କପରେ ଢାଳନ୍ତୁ',
    ],
    hint: 'ଆଗେ ପାଣି, ଶେଷରେ ଚିନି।',
  ),
  'kitchen_breakfast': ActivityContent(
    steps: [
      'କଡ଼େଇ ଧୋଇ ଦିଅନ୍ତୁ',
      'ବ୍ରେଡ ଟୋଷ୍ଟ କରନ୍ତୁ',
      'ଅଣ୍ଡା ଫୁଟାନ୍ତୁ',
      'ଥାଳିରେ ପରଷନ୍ତୁ',
    ],
    hint: 'ରାନ୍ଧିବା ପୂର୍ବରୁ ସବୁ ପରିଷ୍କାର।',
  ),
  'shop_bread_milk': ActivityContent(
    products: [
      Product(id: 'milk', label: 'କ୍ଷୀର ପ୍ୟାକେଟ', price: 27, emoji: '🥛'),
      Product(id: 'bread', label: 'ବ୍ରେଡ', price: 30, emoji: '🍞'),
      Product(id: 'eggs', label: 'ଅଣ୍ଡା (୬)', price: 42, emoji: '🥚'),
      Product(id: 'biscuit', label: 'ବିସ୍କୁଟ', price: 15, emoji: '🍪'),
      Product(id: 'tea', label: 'ଚା ପତ୍ର', price: 55, emoji: '🍵'),
      Product(id: 'rice', label: 'ଚାଉଳ (୧ କି.ଗ୍ରା)', price: 80, emoji: '🍚'),
    ],
    hint: 'କ୍ଷୀର ଓ ବ୍ରେଡ ଦୁହିଁ ମିଶି ₹୧୦୦ ତଳେ।',
  ),
  'shop_vegetables': ActivityContent(
    products: [
      Product(id: 'potato', label: 'ଆଳୁ', price: 25, emoji: '🥔'),
      Product(id: 'onion', label: 'ପିଆଜ', price: 30, emoji: '🧅'),
      Product(id: 'tomato', label: 'ଟମାଟର', price: 20, emoji: '🍅'),
      Product(id: 'ginger', label: 'ଅଦା', price: 12, emoji: '🫚'),
    ],
    hint: 'ଆଳୁ + ପିଆଜ = ₹୫୫।',
  ),
  'rec_kitchen_item': ActivityContent(
    variants: ['🍵 ଚାହା କପ', '🧺 ବାଉଁଶ ଝୁଡ଼ି', '🍚 ଚାଉଳ ବାଟି', '🧊 ବରଫ ବାକ୍ସ'],
    correctLabel: '🧺 ବାଉଁଶ ଝୁଡ଼ି',
    hint: 'ବଜାରରୁ ସାମଗ୍ରୀ ଏଥିରେ ଘରକୁ ଆଣିଥାଉ।',
  ),
  'rec_currency_20': ActivityContent(
    hint: 'ଗୋଟିଏ ବ୍ରେଡର ମୂଲ୍ୟ ପ୍ରାୟ ₹୩୦, ଏଥିରେ ତାହାର ଦୁଇ-ତୃତୀୟାଂଶ ପଡ଼ିଥାଏ। ଏଥିରେ ରଙ୍ଗୀନ ନୋଟ ଅଛି।',
  ),
  'match_festival_food': ActivityContent(
    pairs: [
      MatchPair(left: '🪔 ଦୀପାବଳୀ', right: 'ମିଠା ଲଡ଼ୁ'),
      MatchPair(left: '🎨 ହୋଲି', right: 'ରଙ୍ଗୀନ ଗୁଲାଲ'),
      MatchPair(left: '🌾 ବିହୁ', right: 'ପିଠା'),
      MatchPair(left: '✨ ଈଦ', right: 'ଶୀର ଖୁରମା'),
    ],
    hint: 'ଦୀପାବଳୀ ପାଇଁ ଲଡ଼ୁ।',
  ),
  'match_object_use': ActivityContent(
    pairs: [
      MatchPair(left: '🌂 ଛତା', right: 'ବର୍ଷା'),
      MatchPair(left: '🌡️ ଥର୍ମସ', right: 'ଗରମ ଚା'),
      MatchPair(left: '🪭 ପଙ୍ଖା', right: 'ଗ୍ରୀଷ୍ମ'),
      MatchPair(left: '🧯 କିରୋସିନ ଲାଣ୍ପ', right: 'ବିଜୁଳି ଗଲା'),
    ],
    hint: 'ବର୍ଷାରେ ଏହାର ମନେ ପଡ଼େ।',
  ),
  'seq_morning_routine': ActivityContent(
    steps: ['ଦାନ୍ତ ଘସନ୍ତୁ', 'ମୁହଁ ଧୋଇ ଦିଅନ୍ତୁ', 'ଜଳଖିଆ ଖାଆନ୍ତୁ', 'ଚା ପିଅନ୍ତୁ'],
    hint: 'ଖାଇବା ପରେ ଚା।',
  ),
  'seq_route_guwahati': ActivityContent(
    steps: [
      'ଘରୁ ବାହାରନ୍ତୁ',
      'ରାସ୍ତା ପର୍ଯ୍ୟନ୍ତ ଚାଲନ୍ତୁ',
      'ବସ୍ ଧରନ୍ତୁ',
      'ବଜାରରେ ଓହ୍ଲାନ୍ତୁ',
    ],
    hint: 'ଯାତ୍ରା ଘରୁ ଆରମ୍ଭ।',
  ),
  'asso_region_products': ActivityContent(
    variants: [
      '☕ ଚା ବଗିଚା',
      '🏖️ ସମୁଦ୍ର ବେଳାଭୂମି',
      '🏜️ ବାଲି ଢିପ',
      '❄️ ବରଫ ଚୂଡ଼ା',
    ],
    correctLabel: '☕ ଚା ବଗିଚା',
    hint: 'ଆସାମର ପାହାଡ଼ ସବୁଜ ଚା ବଗିଚା ପାଇଁ ପ୍ରସିଦ୍ଧ।',
  ),
  'asso_harvest_food': ActivityContent(
    variants: ['🥭 ଆମ୍ବ', '🍌 କଦଳି', '🍊 କମଳା', '🌰 ନଡ଼ିଆ'],
    correctLabel: '🥭 ଆମ୍ବ',
    hint: 'ଗ୍ରୀଷ୍ମର ରାଜା ଫଳ, ହଳଦିଆ ଓ ମିଠା।',
  ),
  'attn_find_vegetable': ActivityContent(
    variants: ['🥔 ଆଳୁ', '🌶️ ଲଙ୍କା', '🥕 ଗାଜର', '🧅 ପିଆଜ'],
    correctLabel: '🥕 ଗାଜର',
    hint: 'ଏହା କମଳା ରଙ୍ଗର ଏବଂ ଠେକୁଆକୁ ବହୁତ ଭଲ ଲାଗିଥାଏ।',
  ),
  'recall_family_song': ActivityContent(
    variants: ['🎶 ବିହୁ ଗୀତ', '🎶 ଭଜନ', '🎶 ଲୋରୀ', '🎶 ଚଳଚ୍ଚିତ୍ର ଗୀତ'],
    correctLabel: '🎶 ବିହୁ ଗୀତ',
    hint: 'ବସନ୍ତ ପର୍ବରେ ନର୍ତ୍ତକମାନେ ଏଥିରେ ନାଚନ୍ତି।',
  ),
  'pairs_market_fruits': ActivityContent(
    variants: ['🥭 ଆମ୍ବ', '🍌 କଦଳୀ', '🍊 କମଳା', '🍎 ସେଓ'],
    hint: 'ଠିକ୍ ସମାନ ଦୁଇଟି ଫଳ ଖୋଜ।',
  ),
  'pairs_kitchen_things': ActivityContent(
    variants: ['🍶 କେତଲୀ', '🪭 ହାତ ପଙ୍ଖା', '🧺 ଟୋକରୀ', '🍲 ବଟା'],
    hint: 'ଠିକ୍ ସମାନ ଦୁଇଟି ଜିନିଷ ଖୋଜ।',
  ),
};
