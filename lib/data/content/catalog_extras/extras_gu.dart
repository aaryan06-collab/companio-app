import '../../../domain/entities/activity_content.dart';

/// Gujarati (gu) catalog content overrides. Fields not listed fall back to
/// the English content automatically.
const Map<String, ActivityContent> extrasGu = {
  'kitchen_chai': ActivityContent(
    steps: [
      'પાણી ઉકાળો',
      'ચાના પાન ઉમેરો',
      'દૂધ ઉમેરો',
      'ખાંડ ઉમેરો',
      'ગાળીને કપમાં રેડો',
    ],
    hint: 'પહેલાં પાણી, છેલ્લે ખાંડ.',
  ),
  'kitchen_breakfast': ActivityContent(
    steps: ['તવો ધોઈ લો', 'બ્રેડ ટોસ્ટ કરો', 'ઈંડા ઉકાળો', 'પ્લેટમાં પિરસો'],
    hint: 'રાંધતા પહેલાં બધું સાફ.',
  ),
  'shop_bread_milk': ActivityContent(
    products: [
      Product(id: 'milk', label: 'દૂધની પડિકી', price: 27, emoji: '🥛'),
      Product(id: 'bread', label: 'બ્રેડ', price: 30, emoji: '🍞'),
      Product(id: 'eggs', label: 'ઈંડા (૬)', price: 42, emoji: '🥚'),
      Product(id: 'biscuit', label: 'બિસ્કિટ', price: 15, emoji: '🍪'),
      Product(id: 'tea', label: 'ચાના પાન', price: 55, emoji: '🍵'),
      Product(id: 'rice', label: 'ચોખા (૧ કિલો)', price: 80, emoji: '🍚'),
    ],
    hint: 'દૂધ અને બ્રેડ બંને ₹૧૦૦માં આવી જાય.',
  ),
  'shop_vegetables': ActivityContent(
    products: [
      Product(id: 'potato', label: 'બટાકા', price: 25, emoji: '🥔'),
      Product(id: 'onion', label: 'ડુંગળી', price: 30, emoji: '🧅'),
      Product(id: 'tomato', label: 'ટમેટાં', price: 20, emoji: '🍅'),
      Product(id: 'ginger', label: 'આદુ', price: 12, emoji: '🫚'),
    ],
    hint: 'બટાકા + ડુંગળી = ₹૫૫.',
  ),
  'rec_kitchen_item': ActivityContent(
    variants: [
      '🍵 ચાનો કપ',
      '🧺 વાંસની ટોપલી',
      '🍚 ચોખાનો વાટકો',
      '🧊 બરફનો ડબ્બો',
    ],
    correctLabel: '🧺 વાંસની ટોપલી',
    hint: 'બજારમાંથી સામાન આમાં જ ઘરે લાવીએ.',
  ),
  'rec_currency_20': ActivityContent(
    hint: 'એક બ્રેડની કિંમત લગભગ ₹૩૦ છે, આમાં તેનો બે-તૃતીયાંશ આવી શકે. આમાં રંગીન નોટો છે.',
  ),
  'match_festival_food': ActivityContent(
    pairs: [
      MatchPair(left: '🪔 દિવાળી', right: 'મીઠો લાડવો'),
      MatchPair(left: '🎨 હોળી', right: 'રંગીન ગુલાલ'),
      MatchPair(left: '🌾 બિહુ', right: 'પીઠા'),
      MatchPair(left: '✨ ઈદ', right: 'શીર ખુરમા'),
    ],
    hint: 'દિવાળી માટે લાડવો.',
  ),
  'match_object_use': ActivityContent(
    pairs: [
      MatchPair(left: '🌂 છત્રી', right: 'વરસાદ'),
      MatchPair(left: '🌡️ થર્મોસ', right: 'ગરમ ચા'),
      MatchPair(left: '🪭 પંખો', right: 'ઉનાળો'),
      MatchPair(left: '🧯 કેરોસિન દીવો', right: 'લાઈટ ગઈ'),
    ],
    hint: 'વરસાદમાં આની યાદ આવે.',
  ),
  'seq_morning_routine': ActivityContent(
    steps: ['દાંત સાફ કરો', 'ચહેરો ધોઈ લો', 'નાસ્તો કરો', 'ચા પીઓ'],
    hint: 'જમ્યા પછી ચા.',
  ),
  'seq_route_guwahati': ActivityContent(
    steps: ['ઘરેથી નીકળો', 'રસ્તા સુધી ચાલો', 'બસ પકડો', 'બજારમાં ઊતરો'],
    hint: 'મુસાફરી ઘરેથી શરૂ.',
  ),
  'asso_region_products': ActivityContent(
    variants: [
      '☕ ચાના બગીચા',
      '🏖️ દરિયા કિનારો',
      '🏜️ રણના ટેકરા',
      '❄️ બરફની ટોચ',
    ],
    correctLabel: '☕ ચાના બગીચા',
    hint: 'આસામના ડુંગરા લીલા ચાના બગીચાઓ માટે પ્રસિદ્ધ.',
  ),
  'asso_harvest_food': ActivityContent(
    variants: ['🥭 કેરી', '🍌 કેળા', '🍊 સંતરાં', '🌰 નારિયેળ'],
    correctLabel: '🥭 કેરી',
    hint: 'ઉનાળાનો રાજા ફળ, પીળું અને મીઠું.',
  ),
  'attn_find_vegetable': ActivityContent(
    variants: ['🥔 બટાકા', '🌶️ મરચાં', '🥕 ગાજર', '🧅 ડુંગળી'],
    correctLabel: '🥕 ગાજર',
    hint: 'આ નારંગી છે અને સસલાને બહુ ગમે.',
  ),
  'recall_family_song': ActivityContent(
    variants: ['🎶 બિહુ ગીત', '🎶 ભજન', '🎶 લોરી', '🎶 ફિલ્મ ગીત'],
    correctLabel: '🎶 બિહુ ગીત',
    hint: 'વસંત સ્ણમાં નૃત્યકારો આના પર નાચે.',
  ),
  'pairs_market_fruits': ActivityContent(
    variants: ['🥭 કેરી', '🍌 કેળું', '🍊 નારંગી', '🍎 સફરજન'],
    hint: 'બરાબર એક જ જેવાં બે ફળ શોધો.',
  ),
  'pairs_kitchen_things': ActivityContent(
    variants: ['🍶 કીટલી', '🪭 હાથ પંખો', '🧺 ટોપલી', '🍲 વાટકી'],
    hint: 'બરાબર એક જ જેવી બે વસ્તુ શોધો.',
  ),
};
