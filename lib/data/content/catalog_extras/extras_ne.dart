import '../../../domain/entities/activity_content.dart';

/// Nepali (ne) catalog content overrides. Fields not listed fall back to the
/// English content automatically.
const Map<String, ActivityContent> extrasNe = {
  'kitchen_chai': ActivityContent(
    steps: [
      'पानी उमाल्नुहोस्',
      'चियापाती हाल्नुहोस्',
      'दूध हाल्नुहोस्',
      'चिनी हाल्नुहोस्',
      'छानेर कपमा राख्नुहोस्',
    ],
    hint: 'पहिले पानी, पछि चिनी।',
  ),
  'kitchen_breakfast': ActivityContent(
    steps: [
      'कराई धुनुहोस्',
      'पाउरोटी टोस्ट गर्नुहोस्',
      'अण्डा उमाल्नुहोस्',
      'थालमा परोस्नुहोस्',
    ],
    hint: 'पकाउनुअघि सबै कुरा सफा हुन्छ।',
  ),
  'shop_bread_milk': ActivityContent(
    products: [
      Product(id: 'milk', label: 'दूधको प्याकेट', price: 27, emoji: '🥛'),
      Product(id: 'bread', label: 'पाउरोटी', price: 30, emoji: '🍞'),
      Product(id: 'eggs', label: 'अण्डा (६)', price: 42, emoji: '🥚'),
      Product(id: 'biscuit', label: 'बिस्कुट', price: 15, emoji: '🍪'),
      Product(id: 'tea', label: 'चिया पात', price: 55, emoji: '🍵'),
      Product(id: 'rice', label: 'चामल (१ किलो)', price: 80, emoji: '🍚'),
    ],
    hint: 'दूध र पाउरोटी दुवै ₹१०० भित्र पर्छ।',
  ),
  'shop_vegetables': ActivityContent(
    products: [
      Product(id: 'potato', label: 'आलु', price: 25, emoji: '🥔'),
      Product(id: 'onion', label: 'प्याज', price: 30, emoji: '🧅'),
      Product(id: 'tomato', label: 'गोलभेडा', price: 20, emoji: '🍅'),
      Product(id: 'ginger', label: 'अदुवा', price: 12, emoji: '🫚'),
    ],
    hint: 'आलु + प्याज = ₹५५।',
  ),
  'rec_kitchen_item': ActivityContent(
    variants: [
      '🍵 चियाको कप',
      '🧺 बाँसको डोको',
      '🍚 भातको कचौरा',
      '🧊 बरफको बाकस',
    ],
    correctLabel: '🧺 बाँसको डोको',
    hint: 'बजारबाट सामान यसैमा ल्याउँछौँ।',
  ),
  'rec_currency_20': ActivityContent(
    hint: 'एउटा पाउरोटीको मूल्य करिब ₹३० छ, यसमा त्यसको दुई-तिहाइ पर्छ। यसमा रङ्गीन नोट हुन्छ।',
  ),
  'match_festival_food': ActivityContent(
    pairs: [
      MatchPair(left: '🪔 दिवाली', right: 'मीठो लड्डु'),
      MatchPair(left: '🎨 होली', right: 'रङ्गीन गुलाल'),
      MatchPair(left: '🌾 बिहु', right: 'पिठा'),
      MatchPair(left: '✨ ईद', right: 'सिरखुरमा'),
    ],
    hint: 'लड्डु दियोको पर्वका लागि हो।',
  ),
  'match_object_use': ActivityContent(
    pairs: [
      MatchPair(left: '🌂 छाता', right: 'झरी'),
      MatchPair(left: '🌡️ थर्मस', right: 'तातो चिया'),
      MatchPair(left: '🪭 पङ्खा', right: 'गर्मी'),
      MatchPair(left: '🧯 टुकी बत्ती', right: 'बिजुली गयो'),
    ],
    hint: 'झरीको समयमा यसको सम्झना आउँछ।',
  ),
  'seq_morning_routine': ActivityContent(
    steps: [
      'दाँत माझ्नुहोस्',
      'अनुहार धुनुहोस्',
      'नास्ता गर्नुहोस्',
      'चिया पिउनुहोस्',
    ],
    hint: 'खानाको पछि चिया।',
  ),
  'seq_route_guwahati': ActivityContent(
    steps: [
      'घरबाट निस्कनुहोस्',
      'बाटोसम्म हिँड्नुहोस्',
      'बसमा चढ्नुहोस्',
      'बजारमा झर्नुहोस्',
    ],
    hint: 'यात्रा घरबाट सुरु हुन्छ।',
  ),
  'asso_region_products': ActivityContent(
    variants: [
      '☕ चिया बगान',
      '🏖️ समुद्री किनार',
      '🏜️ मरुभूमिका टिलाहरू',
      '❄️ हिउँले ढाकेका चुचुराहरू',
    ],
    correctLabel: '☕ चिया बगान',
    hint: 'असमका पहाडहरू हरिया चिया बगानका लागि प्रसिद्ध छन्।',
  ),
  'asso_harvest_food': ActivityContent(
    variants: ['🥭 आँप', '🍌 केरा', '🍊 सुन्तला', '🌰 नरिवल'],
    correctLabel: '🥭 आँप',
    hint: 'गर्मीको राजा फल, पहेँलो र मीठो।',
  ),
  'attn_find_vegetable': ActivityContent(
    variants: ['🥔 आलु', '🌶️ खुर्सानी', '🥕 गाजर', '🧅 प्याज'],
    correctLabel: '🥕 गाजर',
    hint: 'यो सुन्तला रङको छ र खरायोलाई धेरै मन पर्छ।',
  ),
  'recall_family_song': ActivityContent(
    variants: ['🎶 बिहु गीत', '🎶 भजन', '🎶 लोरी', '🎶 चलचित्रको गीत'],
    correctLabel: '🎶 बिहु गीत',
    hint: 'वसन्त पर्वमा नर्तकहरू यसमा नाच्छन्।',
  ),
  'pairs_market_fruits': ActivityContent(
    variants: ['🥭 आँप', '🍌 केरा', '🍊 सुन्तला', '🍎 स्याउ'],
    hint: 'उस्तै देखिने दुई फल खोज्नुहोस्।',
  ),
  'pairs_kitchen_things': ActivityContent(
    variants: ['🍶 केतली', '🪭 हाते पंखा', '🧺 डोको', '🍲 कचौरा'],
    hint: 'उस्तै देखिने दुई वस्तु खोज्नुहोस्।',
  ),
};
