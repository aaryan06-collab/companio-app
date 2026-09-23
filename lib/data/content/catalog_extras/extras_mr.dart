import '../../../domain/entities/activity_content.dart';

/// Marathi (mr) catalog content overrides. Fields not listed fall back to the
/// English content automatically.
const Map<String, ActivityContent> extrasMr = {
  'kitchen_chai': ActivityContent(
    steps: [
      'पाणी उकळवा',
      'चहाची पाने घाला',
      'दूध घाला',
      'साखर घाला',
      'गाळून कपात घाला',
    ],
    hint: 'आधी पाणी, शेवटी साखर.',
  ),
  'kitchen_breakfast': ActivityContent(
    steps: [
      'करई धुवा',
      'ब्रेड टोस्ट करा',
      'अंडे उकळवा',
      'प्लेटमध्ये देऊन ठेवा',
    ],
    hint: 'स्वयंपाकापूर्वी सर्व काही स्वच्छ.',
  ),
  'shop_bread_milk': ActivityContent(
    products: [
      Product(id: 'milk', label: 'दुधाची पिशवी', price: 27, emoji: '🥛'),
      Product(id: 'bread', label: 'ब्रेड', price: 30, emoji: '🍞'),
      Product(id: 'eggs', label: 'अंडी (६)', price: 42, emoji: '🥚'),
      Product(id: 'biscuit', label: 'बिस्किटे', price: 15, emoji: '🍪'),
      Product(id: 'tea', label: 'चहाची पाने', price: 55, emoji: '🍵'),
      Product(id: 'rice', label: 'तांदूळ (१ किलो)', price: 80, emoji: '🍚'),
    ],
    hint: 'दूध आणि ब्रेड दोन्ही ₹१०० पेक्षा कमी.',
  ),
  'shop_vegetables': ActivityContent(
    products: [
      Product(id: 'potato', label: 'बटाटे', price: 25, emoji: '🥔'),
      Product(id: 'onion', label: 'कांदे', price: 30, emoji: '🧅'),
      Product(id: 'tomato', label: 'टोमॅटो', price: 20, emoji: '🍅'),
      Product(id: 'ginger', label: 'आलं', price: 12, emoji: '🫚'),
    ],
    hint: 'बटाटे + कांदे = ₹५५.',
  ),
  'rec_kitchen_item': ActivityContent(
    variants: [
      '🍵 चहाचा कप',
      '🧺 बांबूची टोपली',
      '🍚 तांदळाची वाटी',
      '🧊 बर्फाचा डबा',
    ],
    correctLabel: '🧺 बांबूची टोपली',
    hint: 'बाजारातून सामान याच्यात घरी आणतो.',
  ),
  'rec_currency_20': ActivityContent(
    hint: 'एका ब्रेडची किंमत सुमारे ₹३० आहे, यात त्याचा दोन-तृतीयांश येऊ शकतो. यात रंगीत नोटा आहेत.',
  ),
  'match_festival_food': ActivityContent(
    pairs: [
      MatchPair(left: '🪔 दिवाळी', right: 'मीठा लाडू'),
      MatchPair(left: '🎨 होळी', right: 'रंगीत गुलाल'),
      MatchPair(left: '🌾 बिहू', right: 'पिठा'),
      MatchPair(left: '✨ ईद', right: 'शिर खुरमा'),
    ],
    hint: 'दिवाळीच्या सणासाठी लाडू.',
  ),
  'match_object_use': ActivityContent(
    pairs: [
      MatchPair(left: '🌂 छत्री', right: 'पाऊस'),
      MatchPair(left: '🌡️ थर्मॉस', right: 'गरम चहा'),
      MatchPair(left: '🪭 पंखा', right: 'उन्हाळा'),
      MatchPair(left: '🧯 किरोसिनचा दिवा', right: 'वीज गेली'),
    ],
    hint: 'पावसाळ्यात याची आठवण.',
  ),
  'seq_morning_routine': ActivityContent(
    steps: ['दात घासा', 'चेहरा धुवा', 'नाश्ता करा', 'चहा प्या'],
    hint: 'जेवणानंतर चहा.',
  ),
  'seq_route_guwahati': ActivityContent(
    steps: [
      'घरातून बाहेर पडा',
      'रस्त्यापर्यंत चाला',
      'बस पकडा',
      'बाजारात उतरा',
    ],
    hint: 'प्रवास घरापासून सुरू.',
  ),
  'asso_region_products': ActivityContent(
    variants: [
      '☕ चहाचे मळे',
      '🏖️ समुद्रकिनारा',
      '🏜️ वाळवंटी ढिग',
      '❄️ बर्फाचे शिखर',
    ],
    correctLabel: '☕ चहाचे मळे',
    hint: 'आसामचे डोंगर हिरव्या चहाच्या मळ्यांसाठी प्रसिद्ध.',
  ),
  'asso_harvest_food': ActivityContent(
    variants: ['🥭 आंबा', '🍌 केळे', '🍊 संत्री', '🌰 नारळ'],
    correctLabel: '🥭 आंबा',
    hint: 'उन्हाळ्याचा राजा फळ, पिवळे आणि गोड.',
  ),
  'attn_find_vegetable': ActivityContent(
    variants: ['🥔 बटाटे', '🌶️ मिरची', '🥕 गाजर', '🧅 कांदे'],
    correctLabel: '🥕 गाजर',
    hint: 'हे केशरी असून सशाला आवडते.',
  ),
  'recall_family_song': ActivityContent(
    variants: ['🎶 बिहू गाणे', '🎶 भजन', '🎶 लोरी', '🎶 चित्रपट गाणे'],
    correctLabel: '🎶 बिहू गाणे',
    hint: 'वसंत सणात नर्तक त्यावर नाचतात.',
  ),
  'pairs_market_fruits': ActivityContent(
    variants: ['🥭 आंबा', '🍌 केळे', '🍊 संत्रे', '🍎 सफरचंद'],
    hint: 'सारखीच दोन फळे शोधा.',
  ),
  'pairs_kitchen_things': ActivityContent(
    variants: ['🍶 किटली', '🪭 हात पंखा', '🧺 टोपली', '🍲 वाटी'],
    hint: 'सारख्याच दोन वस्तू शोधा.',
  ),
};
