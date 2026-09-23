import '../../../domain/entities/activity_content.dart';

/// Bodo (brx) catalog content overrides. Fields not listed fall back to the
/// English content automatically. Core terms corroborated against xobdo.org.
const Map<String, ActivityContent> extrasBrx = {
  'kitchen_chai': ActivityContent(
    steps: [
      'दै फोफोन',
      'साह पि पिनबि',
      'गाइखेर पिनबि',
      'सिनि पिनबि',
      'साह सथफिनाय गोसेनन कपा लु',
    ],
    hint: 'आग बाइखुलि दै, आखिर सिनि।',
  ),
  'kitchen_breakfast': ActivityContent(
    steps: [
      'कराहि खाला बिनोबि',
      'ब्रेड टोस्ट खालाम',
      'सिम उसियबि',
      'प्लेटोन सुवान्थाय खालाम',
    ],
    hint: 'नोनायनि थौनियानि शानथा गुदुनिया सिगां खाला खालामोद।',
  ),
  'shop_bread_milk': ActivityContent(
    products: [
      Product(id: 'milk', label: 'गाइखेर प्याकेट', price: 27, emoji: '🥛'),
      Product(id: 'bread', label: 'ब्रेड', price: 30, emoji: '🍞'),
      Product(id: 'eggs', label: 'सिम (६)', price: 42, emoji: '🥚'),
      Product(id: 'biscuit', label: 'बिस्कुट', price: 15, emoji: '🍪'),
      Product(id: 'tea', label: 'साह पि', price: 55, emoji: '🍵'),
      Product(id: 'rice', label: 'माइरं (१ किलो)', price: 80, emoji: '🍚'),
    ],
    hint: 'गाइखेर आरो ब्रेड ₹100 नि उनै ओंनो हायो।',
  ),
  'shop_vegetables': ActivityContent(
    products: [
      Product(id: 'potato', label: 'आलु', price: 25, emoji: '🥔'),
      Product(id: 'onion', label: 'सामब्राम', price: 30, emoji: '🧅'),
      Product(id: 'tomato', label: 'बिलाथी फान्थाव', price: 20, emoji: '🍅'),
      Product(id: 'ginger', label: 'हाइजें', price: 12, emoji: '🫚'),
    ],
    hint: 'आलु + सामब्राम = ₹55।',
  ),
  'rec_kitchen_item': ActivityContent(
    variants: [
      '🍵 साहनि कप',
      '🧺 अगं बिदु बुंनाय',
      '🍚 माइरंनि बाथिन',
      '🧊 बरफनि बाकस',
    ],
    correctLabel: '🧺 अगं बिदु बुंनाय',
    hint: 'बजारओनि बसथुयैखौ बेदिनि दिथुङदा घरआव लाङो।',
  ),
  'rec_currency_20': ActivityContent(
    hint: 'मोनसे ब्रेडनि मोल ₹30 जानैरै, बेदिनि नोआ मोनथाइसु थाँनय मोनटो। बेदिनि गुबुन रङनि नोट गाहायो।',
  ),
  'match_festival_food': ActivityContent(
    pairs: [
      MatchPair(left: '🪔 दीपावली', right: 'आखा लादु'),
      MatchPair(left: '🎨 होली', right: 'रङ गुलोम'),
      MatchPair(left: '🌾 बिहु', right: 'फिथा थालि'),
      MatchPair(left: '✨ ईद', right: 'शिर खुरमा'),
    ],
    hint: 'लादु नानगुदुजिनि फुलेगन दिनखौ लागोन।',
  ),
  'match_object_use': ActivityContent(
    pairs: [
      MatchPair(left: '🌂 छाता', right: 'जादोर'),
      MatchPair(left: '🌡️ थर्मस', right: 'सान दाइ'),
      MatchPair(left: '🪭 हातथा फिपिर', right: 'जाङनि सानजा'),
      MatchPair(left: '🧯 केरासिन ल्याम्प', right: 'बिजुली गाहाया'),
    ],
    hint: 'जादोरनि जखाथियाव बेदिनि सोमाजी होनाय जायो।',
  ),
  'seq_morning_routine': ActivityContent(
    steps: ['दां खाला खालाम', 'मुर खाला बिनो', 'बेउथन खालाम', 'साह थुइ'],
    hint: 'बेउसिनि उनै साह थुइयो।',
  ),
  'seq_route_guwahati': ActivityContent(
    steps: [
      'नोइफ्रोन बाङो',
      'हथुसारिङाव फन-फन लाङो',
      'बसाव फु',
      'बजाराओ दगायो',
    ],
    hint: 'जादोयअ नोइफ्रोननि शारननै सुबुआबोयो।',
  ),
  'asso_region_products': ActivityContent(
    variants: [
      '☕ साह बागान',
      '🏖️ समुद्रनि जोबोना',
      '🏜️ बानफिनि थुल',
      '❄️ बरफनि खोंथि',
    ],
    correctLabel: '☕ साह बागान',
    hint: 'आसामनि हाजाङफरा गेदेरस्रोहां साह बागाननि गिदिंनो खादिला।',
  ),
  'asso_harvest_food': ActivityContent(
    variants: ['🥭 थाइजौ', '🍌 थालि', '🍊 कमला', '🌰 नारियल'],
    correctLabel: '🥭 थाइजौ',
    hint: 'जाङनि थोन्दाइ फलाय, डोड अरो आखा।',
  ),
  'attn_find_vegetable': ActivityContent(
    variants: ['🥔 आलु', '🌶️ गेजेर', '🥕 गाजर', '🧅 सामब्राम'],
    correctLabel: '🥕 गाजर',
    hint: 'बेयो अरोन रङ, आरो सासो मोनोनो माबो खिनानो जाबो।',
  ),
  'recall_family_song': ActivityContent(
    variants: ['🎶 बिहु सरइ', '🎶 भजन', '🎶 हागिनि थुनाय', '🎶 फिलिम सरइ'],
    correctLabel: '🎶 बिहु सरइ',
    hint: 'सानथाय बादथिखोंनि थाननि मावगिरि मोनसाया बेदाव फोलिना उयो।',
  ),
  'pairs_market_fruits': ActivityContent(
    variants: ['🥭 आम', '🍌 केला', '🍊 तेला', '🍎 सेब'],
    hint: 'मोननै जेबा बादियाव फोरैखौ खा।',
  ),
  'pairs_kitchen_things': ActivityContent(
    variants: ['🍶 कित्लि', '🪭 फखना', '🧺 खंद्रा', '🍲 कटोरा'],
    hint: 'मोननै जेबा बादियाव सामानखौ खा।',
  ),
};
