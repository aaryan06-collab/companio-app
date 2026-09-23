import '../../../domain/entities/activity_content.dart';

/// Telugu (te) catalog content overrides. Fields not listed fall back to the
/// English content automatically.
const Map<String, ActivityContent> extrasTe = {
  'kitchen_chai': ActivityContent(
    steps: [
      'నీళ్లు మరిగించు',
      'టీ ఆకులు వేయి',
      'పాలు వేయి',
      'చక్కెర వేయి',
      'వడకట్టి కప్పులో పోయి',
    ],
    hint: 'ముందు నీళ్లు, చివర చక్కెర.',
  ),
  'kitchen_breakfast': ActivityContent(
    steps: [
      'పెనం కడుగు',
      'బ్రెడ్ టోస్ట్ చేయి',
      'గుడ్లు మరిగించు',
      'పళ్లెంలో అందించు',
    ],
    hint: 'వంటకు ముందు అంతా శుభ్రం.',
  ),
  'shop_bread_milk': ActivityContent(
    products: [
      Product(id: 'milk', label: 'పాలు ప్యాకెట్', price: 27, emoji: '🥛'),
      Product(id: 'bread', label: 'బ్రెడ్', price: 30, emoji: '🍞'),
      Product(id: 'eggs', label: 'గుడ్లు (6)', price: 42, emoji: '🥚'),
      Product(id: 'biscuit', label: 'బిస్కట్', price: 15, emoji: '🍪'),
      Product(id: 'tea', label: 'టీ ఆకులు', price: 55, emoji: '🍵'),
      Product(id: 'rice', label: 'బియ్యం (1 కిలో)', price: 80, emoji: '🍚'),
    ],
    hint: 'పాలు మరియు బ్రెడ్ రెండూ ₹100 లోపే.',
  ),
  'shop_vegetables': ActivityContent(
    products: [
      Product(id: 'potato', label: 'బంగాళాదుంప', price: 25, emoji: '🥔'),
      Product(id: 'onion', label: 'ఉల్లిపాయ', price: 30, emoji: '🧅'),
      Product(id: 'tomato', label: 'టమోటా', price: 20, emoji: '🍅'),
      Product(id: 'ginger', label: 'అల్లం', price: 12, emoji: '🫚'),
    ],
    hint: 'బంగాళాదుంప + ఉల్లిపాయ = ₹55.',
  ),
  'rec_kitchen_item': ActivityContent(
    variants: [
      '🍵 టీ కప్పు',
      '🧺 వెదురు బుట్ట',
      '🍚 అన్నం గిన్నె',
      '🧊 మంచు పెట్టె',
    ],
    correctLabel: '🧺 వెదురు బుట్ట',
    hint: 'మార్కెట్ నుంచి సామాన్లు ఇందులోనే ఇంటికి తెచ్చేవాళ్లం.',
  ),
  'rec_currency_20': ActivityContent(
    hint: 'ఒక బ్రెడ్ ధర సుమారు ₹30, ఇందులో దాని రెండు వంతులు వస్తాయి. ఇందులో రంగురంగుల నోట్లు ఉన్నాయి.',
  ),
  'match_festival_food': ActivityContent(
    pairs: [
      MatchPair(left: '🪔 దీపావళి', right: 'తీపి లడ్డు'),
      MatchPair(left: '🎨 హోలీ', right: 'రంగుల గులాల్'),
      MatchPair(left: '🌾 బిహు', right: 'పిఠా'),
      MatchPair(left: '✨ ఈద్', right: 'షీర్ ఖుర్మా'),
    ],
    hint: 'దీపాల పండుగకు లడ్డు.',
  ),
  'match_object_use': ActivityContent(
    pairs: [
      MatchPair(left: '🌂 గొడుగు', right: 'వర్షం'),
      MatchPair(left: '🌡️ థర్మస్', right: 'వేడి టీ'),
      MatchPair(left: '🪭 చేతి విసనకర్ర', right: 'వేసవి'),
      MatchPair(left: '🧯 కిరోసిన్ దీపం', right: 'కరెంటు లేదు'),
    ],
    hint: 'వర్షాకాలంలో ఇది గుర్తొస్తుంది.',
  ),
  'seq_morning_routine': ActivityContent(
    steps: ['పళ్లు తోముకో', 'మొహం కడుగుకో', 'ఉదయం భోజనం చెయ్యి', 'టీ తాగు'],
    hint: 'తిన్న తర్వాత టీ.',
  ),
  'seq_route_guwahati': ActivityContent(
    steps: [
      'ఇంటి నుంచి బయలుదేరు',
      'రోడ్డు వరకు నడువు',
      'బస్సు ఎక్కు',
      'మార్కెట్లో దిగు',
    ],
    hint: 'ప్రయాణం ఇంటి నుంచి మొదలవుతుంది.',
  ),
  'asso_region_products': ActivityContent(
    variants: [
      '☕ టీ తోటలు',
      '🏖️ సముద్ర తీరం',
      '🏜️ ఇసుక దిబ్బ',
      '❄️ మంచు శిఖరాలు',
    ],
    correctLabel: '☕ టీ తోటలు',
    hint: 'అస్సాం కొండలు పచ్చని టీ తోటలకు ప్రసిద్ధి.',
  ),
  'asso_harvest_food': ActivityContent(
    variants: ['🥭 మామిడి', '🍌 అరటి', '🍊 నారింజ', '🌰 కొబ్బరికాయ'],
    correctLabel: '🥭 మామిడి',
    hint: 'వేసవి రాజు పండు, పసుపు మరియు తీపి.',
  ),
  'attn_find_vegetable': ActivityContent(
    variants: ['🥔 బంగాళాదుంప', '🌶️ మిరపకాయ', '🥕 క్యారెట్', '🧅 ఉల్లిపాయ'],
    correctLabel: '🥕 క్యారెట్',
    hint: 'ఇది నారింజ రంగు, కుందేలుకు చాలా ఇష్టం.',
  ),
  'recall_family_song': ActivityContent(
    variants: ['🎶 బిహు పాట', '🎶 భజన', '🎶 జోల పాట', '🎶 సినిమా పాట'],
    correctLabel: '🎶 బిహు పాట',
    hint: 'వసంత పండుగలో నృత్యకారులు దీనిపై నాట్యం చేస్తారు.',
  ),
  'pairs_market_fruits': ActivityContent(
    variants: ['🥭 మామిడి', '🍌 అరటి', '🍊 నారింజ', '🍎 ఆపిల్'],
    hint: 'సరిగ్గా ఒకేలా ఉండే రెండు పండ్లను కనుగొనండి.',
  ),
  'pairs_kitchen_things': ActivityContent(
    variants: ['🍶 కెటిల్', '🪭 చేతి విసనకర్ర', '🧺 బుట్ట', '🍲 గిన్నె'],
    hint: 'సరిగ్గా ఒకేలా ఉండే రెండు వస్తువులను కనుగొనండి.',
  ),
};
