import '../../../domain/entities/activity_content.dart';

/// Malayalam (ml) catalog content overrides. Fields not listed fall back to
/// the English content automatically.
const Map<String, ActivityContent> extrasMl = {
  'kitchen_chai': ActivityContent(
    steps: [
      'വെള്ളം തിളപ്പിക്കുക',
      'ചായയിലകൾ ഇടുക',
      'പാൽ ഇടുക',
      'പഞ്ചസാര ഇടുക',
      'അരിച്ച് കപ്പിലേക്ക് ഒഴിക്കുക',
    ],
    hint: 'ആദ്യം വെള്ളം, ഒടുവിൽ പഞ്ചസാര.',
  ),
  'kitchen_breakfast': ActivityContent(
    steps: [
      'പാത്രം കഴുകുക',
      'ബ്രെഡ് ടോസ്റ്റ് ചെയ്യുക',
      'മുട്ട തിളപ്പിക്കുക',
      'പ്ലേറ്റിൽ വിളമ്പുക',
    ],
    hint: 'വേവിക്കുന്നതിനു മുമ്പ് എല്ലാം വൃത്തിയാണ്.',
  ),
  'shop_bread_milk': ActivityContent(
    products: [
      Product(id: 'milk', label: 'പാൽ പാക്കറ്റ്', price: 27, emoji: '🥛'),
      Product(id: 'bread', label: 'ബ്രെഡ്', price: 30, emoji: '🍞'),
      Product(id: 'eggs', label: 'മുട്ട (6)', price: 42, emoji: '🥚'),
      Product(id: 'biscuit', label: 'ബിസ്കറ്റ്', price: 15, emoji: '🍪'),
      Product(id: 'tea', label: 'ചായയില', price: 55, emoji: '🍵'),
      Product(id: 'rice', label: 'അരി (1 കിലോ)', price: 80, emoji: '🍚'),
    ],
    hint: 'പാലും ബ്രെഡും ഒന്നിച്ച് ₹100-ൽ കുറവ്.',
  ),
  'shop_vegetables': ActivityContent(
    products: [
      Product(id: 'potato', label: 'ഉരുളക്കിഴങ്ങ്', price: 25, emoji: '🥔'),
      Product(id: 'onion', label: 'സവാള', price: 30, emoji: '🧅'),
      Product(id: 'tomato', label: 'തക്കാളി', price: 20, emoji: '🍅'),
      Product(id: 'ginger', label: 'ഇഞ്ചി', price: 12, emoji: '🫚'),
    ],
    hint: 'ഉരുളക്കിഴങ്ങ് + സവാള = ₹55.',
  ),
  'rec_kitchen_item': ActivityContent(
    variants: [
      '🍵 ചായക്കപ്പ്',
      '🧺 മുളങ്കൊലി കൊട്ട',
      '🍚 ചോറ്റ് പാത്രം',
      '🧊 ഐസ് പെട്ടി',
    ],
    correctLabel: '🧺 മുളങ്കൊലി കൊട്ട',
    hint: 'ചന്തയിൽനിന്ന് സാധനങ്ങൾ ഇതിൽ വീട്ടിലേക്ക് കൊണ്ടുവരുന്നു.',
  ),
  'rec_currency_20': ActivityContent(
    hint: 'ഒരു ബ്രെഡിന്റെ വില ഏകദേശം ₹30, ഇതിൽ അതിന്റെ മൂന്നിൽ രണ്ട് ഭാഗം വരും. ഇതിൽ നിറമുള്ള നോട്ടുകളുണ്ട്.',
  ),
  'match_festival_food': ActivityContent(
    pairs: [
      MatchPair(left: '🪔 ദീപാവലി', right: 'മധുര ലഡ്ഡു'),
      MatchPair(left: '🎨 ഹോളി', right: 'നിറമുള്ള ഗുലാൽ'),
      MatchPair(left: '🌾 ബിഹു', right: 'പിത്ത'),
      MatchPair(left: '✨ ഈദ്', right: 'ഷീർ ഖുർമ'),
    ],
    hint: 'ദീപാവലിക്ക് ലഡ്ഡു.',
  ),
  'match_object_use': ActivityContent(
    pairs: [
      MatchPair(left: '🌂 കുട', right: 'മഴ'),
      MatchPair(left: '🌡️ തെർമോസ്', right: 'ചൂടുള്ള ചായ'),
      MatchPair(left: '🪭 കൈ വിശറി', right: 'വേനൽ'),
      MatchPair(left: '🧯 മണ്ണെണ്ണ വിളക്ക്', right: 'വൈദ്യുതി ഇല്ല'),
    ],
    hint: 'മഴക്കാലത്ത് ഇത് ഓർമ്മവരും.',
  ),
  'seq_morning_routine': ActivityContent(
    steps: [
      'പല്ല് തേക്കുക',
      'മുഖം കഴുകുക',
      'പ്രഭാത ഭക്ഷണം കഴിക്കുക',
      'ചായ കുടിക്കുക',
    ],
    hint: 'കഴിച്ചതിന് ശേഷം ചായ.',
  ),
  'seq_route_guwahati': ActivityContent(
    steps: [
      'വീട്ടിൽനിന്ന് പുറപ്പെടുക',
      'റോഡുവരെ നടക്കുക',
      'ബസ് കയറുക',
      'ചന്തയിൽ ഇറങ്ങുക',
    ],
    hint: 'യാത്ര വീട്ടിൽനിന്ന് തുടങ്ങുന്നു.',
  ),
  'asso_region_products': ActivityContent(
    variants: [
      '☕ ചായത്തോട്ടങ്ങൾ',
      '🏖️ കടൽത്തീരം',
      '🏜️ മണൽ കുന്ന്',
      '❄️ മഞ്ഞ് കൊടുമുടികൾ',
    ],
    correctLabel: '☕ ചായത്തോട്ടങ്ങൾ',
    hint: 'അസമിലെ കുന്നുകൾ ഹരിത ചായത്തോട്ടങ്ങൾക്ക് പ്രശസ്തമാണ്.',
  ),
  'asso_harvest_food': ActivityContent(
    variants: ['🥭 മാങ്ങ', '🍌 വാഴപ്പഴം', '🍊 ഓറഞ്ച്', '🌰 തേങ്ങ'],
    correctLabel: '🥭 മാങ്ങ',
    hint: 'വേനൽക്കാല രാജാവായ പഴം, മഞ്ഞയും മധുരവും.',
  ),
  'attn_find_vegetable': ActivityContent(
    variants: ['🥔 ഉരുളക്കിഴങ്ങ്', '🌶️ മുളക്', '🥕 കാരറ്റ്', '🧅 സവാള'],
    correctLabel: '🥕 കാരറ്റ്',
    hint: 'ഇത് ഓറഞ്ച് നിറമാണ്, മുയലിന് വളരെ ഇഷ്ടമാണ്.',
  ),
  'recall_family_song': ActivityContent(
    variants: ['🎶 ബിഹു പാട്ട്', '🎶 ഭജൻ', '🎶 താരാട്ട്', '🎶 സിനിമ പാട്ട്'],
    correctLabel: '🎶 ബിഹു പാട്ട്',
    hint: 'വസന്ത ഉത്സവത്തിൽ നർത്തകർ ഇതിനനുസരിച്ച് നൃത്തം ചെയ്യുന്നു.',
  ),
  'pairs_market_fruits': ActivityContent(
    variants: ['🥭 മാങ്ങ', '🍌 വാഴപ്പഴം', '🍊 ഓറഞ്ച്', '🍎 ആപ്പിൾ'],
    hint: 'ഒരേ പോലെയുള്ള രണ്ട് പഴങ്ങൾ കണ്ടെത്തുക.',
  ),
  'pairs_kitchen_things': ActivityContent(
    variants: ['🍶 കെറ്റിൽ', '🪭 കൈവീശൽ', '🧺 കുട്ട', '🍲 പാത്രം'],
    hint: 'ഒരേ പോലെയുള്ള രണ്ട് വസ്തുക്കൾ കണ്ടെത്തുക.',
  ),
};
