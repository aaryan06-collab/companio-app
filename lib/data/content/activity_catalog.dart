import '../../domain/entities/activity_content.dart';
import '../models/enums.dart';
import 'catalog_extras.dart';

/// The curated Companio activity catalog.
///
/// All activities are data-driven and multilingual. The base list ships
/// English and Hindi; per-language rich content (steps, pairs, product
/// labels, hints) from [CatalogExtras] is attached for every other supported
/// language. The database `activities` table is seeded from [all], hydrated
/// for the patient's language.
abstract final class ActivityCatalog {
  static List<CatalogActivity> get all => _base
      .map((a) {
        final langExtras = CatalogExtras.all[a.id];
        return CatalogActivity(
          id: a.id,
          type: a.type,
          titleKey: a.titleKey,
          subtitleKey: a.subtitleKey,
          category: a.category,
          baseDifficulty: a.baseDifficulty,
          durationSec: a.durationSec,
          content: LocalizedContent(
            en: a.content.en,
            hi: a.content.hi,
            extra: langExtras ?? const {},
          ),
        );
      })
      .toList(growable: false);

  static final List<CatalogActivity> _base = [
    // ── Virtual kitchen ────────────────────────────────────────────
    const CatalogActivity(
      id: 'kitchen_chai',
      type: ActivityType.kitchen,
      titleKey: 'kitchenTitle',
      subtitleKey: 'teaserChai',
      category: 'memory',
      baseDifficulty: Difficulty.gentle,
      durationSec: 180,
      content: LocalizedContent(
        en: ActivityContent(
          prompt: 'kitchenMakeChaiPrompt',
          promptEmoji: '🍵',
          steps: [
            'Boil water',
            'Add tea leaves',
            'Add milk',
            'Add sugar',
            'Strain into cup',
          ],
          hint: 'Water first, sugar last.',
        ),
        hi: ActivityContent(
          prompt: 'kitchenMakeChaiPrompt',
          promptEmoji: '🍵',
          steps: [
            'पानी उबालें',
            'चायपत्ती डालें',
            'दूध डालें',
            'चीनी डालें',
            'छानकर प्याली में डालें',
          ],
          hint: 'पहले पानी, आखिर में चीनी।',
        ),
      ),
    ),
    const CatalogActivity(
      id: 'kitchen_breakfast',
      type: ActivityType.kitchen,
      titleKey: 'kitchenBreakfast',
      subtitleKey: 'kitchenBreakfastHint',
      category: 'everyday',
      baseDifficulty: Difficulty.gentle,
      durationSec: 180,
      content: LocalizedContent(
        en: ActivityContent(
          prompt: 'kitchenBreakfastPrompt',
          promptEmoji: '🥣',
          steps: [
            'Wash the pan',
            'Toast the bread',
            'Boil the egg',
            'Serve on plate',
          ],
          hint: 'Everything is cleaned before cooking.',
        ),
        hi: ActivityContent(
          prompt: 'kitchenBreakfastPrompt',
          promptEmoji: '🥣',
          steps: [
            'पैन धोएँ',
            'ब्रेड टोस्ट करें',
            'अंडा उबालें',
            'प्लेट में परोसें',
          ],
          hint: 'सब कुछ पकाने से पहले साफ़ होता है।',
        ),
      ),
    ),

    // ── Virtual shopping ───────────────────────────────────────────
    const CatalogActivity(
      id: 'shop_bread_milk',
      type: ActivityType.shopping,
      titleKey: 'shopTitle',
      subtitleKey: 'shopGetMilkBread',
      category: 'everyday',
      baseDifficulty: Difficulty.gentle,
      durationSec: 180,
      content: LocalizedContent(
        en: ActivityContent(
          prompt: 'shopGetMilkBreadPrompt',
          promptEmoji: '🛒',
          budget: 100,
          requiredProductIds: ['milk', 'bread'],
          products: [
            Product(id: 'milk', label: 'Milk pouch', price: 27, emoji: '🥛'),
            Product(id: 'bread', label: 'Bread', price: 30, emoji: '🍞'),
            Product(id: 'eggs', label: 'Eggs (6)', price: 42, emoji: '🥚'),
            Product(id: 'biscuit', label: 'Biscuits', price: 15, emoji: '🍪'),
            Product(id: 'tea', label: 'Tea leaves', price: 55, emoji: '🍵'),
            Product(id: 'rice', label: 'Rice (1kg)', price: 80, emoji: '🍚'),
          ],
          hint: 'Milk and bread together stay under ₹100.',
        ),
        hi: ActivityContent(
          prompt: 'shopGetMilkBreadPrompt',
          promptEmoji: '🛒',
          budget: 100,
          requiredProductIds: ['milk', 'bread'],
          products: [
            Product(id: 'milk', label: 'दूध की पाउच', price: 27, emoji: '🥛'),
            Product(id: 'bread', label: 'ब्रेड', price: 30, emoji: '🍞'),
            Product(id: 'eggs', label: 'अंडे (६)', price: 42, emoji: '🥚'),
            Product(id: 'biscuit', label: 'बिस्कुट', price: 15, emoji: '🍪'),
            Product(id: 'tea', label: 'चायपत्ती', price: 55, emoji: '🍵'),
            Product(id: 'rice', label: 'चावल (१ किलो)', price: 80, emoji: '🍚'),
          ],
          hint: 'दूध और ब्रेड साथ ₹100 से कम में आ जाते हैं।',
        ),
      ),
    ),
    const CatalogActivity(
      id: 'shop_vegetables',
      type: ActivityType.shopping,
      titleKey: 'shopTitle',
      subtitleKey: 'shopVeggies',
      category: 'everyday',
      baseDifficulty: Difficulty.comfortable,
      durationSec: 240,
      content: LocalizedContent(
        en: ActivityContent(
          prompt: 'shopVeggiesPrompt',
          promptEmoji: '🥬',
          budget: 60,
          requiredProductIds: ['potato', 'onion'],
          products: [
            Product(id: 'potato', label: 'Potatoes', price: 25, emoji: '🥔'),
            Product(id: 'onion', label: 'Onions', price: 30, emoji: '🧅'),
            Product(id: 'tomato', label: 'Tomatoes', price: 20, emoji: '🍅'),
            Product(
              id: 'ginger',
              label: 'Ginger small',
              price: 12,
              emoji: '🫚',
            ),
          ],
          hint: 'Potato + onion = ₹55.',
        ),
        hi: ActivityContent(
          prompt: 'shopVeggiesPrompt',
          promptEmoji: '🥬',
          budget: 60,
          requiredProductIds: ['potato', 'onion'],
          products: [
            Product(id: 'potato', label: 'आलू', price: 25, emoji: '🥔'),
            Product(id: 'onion', label: 'प्याज़', price: 30, emoji: '🧅'),
            Product(id: 'tomato', label: 'टमाटर', price: 20, emoji: '🍅'),
            Product(id: 'ginger', label: 'अदरक (छोटा)', price: 12, emoji: '🫚'),
          ],
          hint: 'आलू + प्याज़ = ₹55।',
        ),
      ),
    ),

    // ── Recognition ────────────────────────────────────────────────
    const CatalogActivity(
      id: 'rec_kitchen_item',
      type: ActivityType.recognition,
      titleKey: 'activityRecognition',
      subtitleKey: 'recKitchenItem',
      category: 'memory',
      baseDifficulty: Difficulty.gentle,
      durationSec: 90,
      content: LocalizedContent(
        en: ActivityContent(
          prompt: 'recKitchenItemPrompt',
          promptEmoji: '⚱️',
          variants: [
            '🍵 Teacup',
            '🧺 Bamboo basket',
            '🍚 Rice bowl',
            '🧊 Ice box',
          ],
          correctLabel: '🧺 Bamboo basket',
          hint: 'We carry things home from the market in it.',
        ),
        hi: ActivityContent(
          prompt: 'recKitchenItemPrompt',
          promptEmoji: '⚱️',
          variants: [
            '🍵 चाय की प्याली',
            '🧺 बाँस की टोकरी',
            '🍚 चावल की कटोरी',
            '🧊 बर्फ़ का डिब्बा',
          ],
          correctLabel: '🧺 बाँस की टोकरी',
          hint: 'बाज़ार से सामान इसी में लाते हैं।',
        ),
      ),
    ),
    const CatalogActivity(
      id: 'rec_currency_20',
      type: ActivityType.recognition,
      titleKey: 'activityRecognition',
      subtitleKey: 'recCurrency',
      category: 'numeracy',
      baseDifficulty: Difficulty.comfortable,
      durationSec: 90,
      content: LocalizedContent(
        en: ActivityContent(
          prompt: 'recCurrencyPrompt',
          promptEmoji: '💵',
          variants: ['₹5', '₹10', '₹20', '₹50'],
          correctLabel: '₹20',
          hint: 'One bread costs about ₹30, this buys two-thirds of it. It has colourful notes.',
        ),
        hi: ActivityContent(
          prompt: 'recCurrencyPrompt',
          promptEmoji: '💵',
          variants: ['₹5', '₹10', '₹20', '₹50'],
          correctLabel: '₹20',
          hint: 'ब्रेड की कीमत लगभग ₹30 है, इसमें उसके दो तिहाई दे सकते हैं।',
        ),
      ),
    ),

    // ── Matching ───────────────────────────────────────────────────
    const CatalogActivity(
      id: 'match_festival_food',
      type: ActivityType.matching,
      titleKey: 'activityMatching',
      subtitleKey: 'matchFestival',
      category: 'festivals',
      baseDifficulty: Difficulty.comfortable,
      durationSec: 180,
      content: LocalizedContent(
        en: ActivityContent(
          prompt: 'matchFestivalPrompt',
          pairs: [
            MatchPair(left: '🪔 Diwali', right: 'Sweet laddoo'),
            MatchPair(left: '🎨 Holi', right: 'Colourful gulal'),
            MatchPair(left: '🌾 Bihu', right: 'Pitha rice cake'),
            MatchPair(left: '✨ Eid', right: 'Sheer khurma'),
          ],
          hint: 'Laddoo is for the festival of lights.',
        ),
        hi: ActivityContent(
          prompt: 'matchFestivalPrompt',
          pairs: [
            MatchPair(left: '🪔 दिवाली', right: 'मीठा लड्डू'),
            MatchPair(left: '🎨 होली', right: 'रंगीन गुलाल'),
            MatchPair(left: '🌾 बिहू', right: 'पिठा चावल की पकवानी'),
            MatchPair(left: '✨ ईद', right: 'शीर खुरमा'),
          ],
          hint: 'रोशनी के त्योहार का है लड्डू।',
        ),
      ),
    ),
    const CatalogActivity(
      id: 'match_object_use',
      type: ActivityType.matching,
      titleKey: 'activityMatching',
      subtitleKey: 'matchObjectUse',
      category: 'memory',
      baseDifficulty: Difficulty.gentle,
      durationSec: 180,
      content: LocalizedContent(
        en: ActivityContent(
          prompt: 'matchObjectUsePrompt',
          pairs: [
            MatchPair(left: '🌂 Umbrella', right: 'Rain'),
            MatchPair(left: '🌡️ Thermos', right: 'Hot chai'),
            MatchPair(left: '🪭 Hand fan', right: 'Summer heat'),
            MatchPair(left: '🧯 Kerosene lamp', right: 'Power cut'),
          ],
          hint: 'Monsoon weather makes you reach for it.',
        ),
        hi: ActivityContent(
          prompt: 'matchObjectUsePrompt',
          pairs: [
            MatchPair(left: '🌂 छाता', right: 'बारिश'),
            MatchPair(left: '🌡️ थर्मस', right: 'गरम चाय'),
            MatchPair(left: '🪭 पंखा', right: 'गर्मी की तपिश'),
            MatchPair(left: '🧯 केरोसिन लालटेन', right: 'बिजली गुल'),
          ],
          hint: 'बारिश के मौसम में इसकी याद आती है।',
        ),
      ),
    ),

    // ── Sequencing ─────────────────────────────────────────────────
    const CatalogActivity(
      id: 'seq_morning_routine',
      type: ActivityType.sequence,
      titleKey: 'activitySequence',
      subtitleKey: 'seqMorning',
      category: 'everyday',
      baseDifficulty: Difficulty.comfortable,
      durationSec: 150,
      content: LocalizedContent(
        en: ActivityContent(
          prompt: 'seqMorningPrompt',
          promptEmoji: '🪥',
          steps: ['Brush teeth', 'Wash face', 'Have breakfast', 'Drink tea'],
          hint: 'Tea comes after food.',
        ),
        hi: ActivityContent(
          prompt: 'seqMorningPrompt',
          promptEmoji: '🪥',
          steps: ['दाँत साफ़ करें', 'मुँह धोएँ', 'नाश्ता करें', 'चाय पिएँ'],
          hint: 'खाने के बाद चाय आती है।',
        ),
      ),
    ),
    const CatalogActivity(
      id: 'seq_route_guwahati',
      type: ActivityType.sequence,
      titleKey: 'activitySequence',
      subtitleKey: 'seqRoute',
      category: 'region',
      baseDifficulty: Difficulty.comfortable,
      durationSec: 150,
      content: LocalizedContent(
        en: ActivityContent(
          prompt: 'seqRoutePrompt',
          promptEmoji: '🛶',
          steps: [
            'Leave home',
            'Walk to the road',
            'Take the bus',
            'Get off at market',
          ],
          hint: 'The journey begins at home.',
        ),
        hi: ActivityContent(
          prompt: 'seqRoutePrompt',
          promptEmoji: '🛶',
          steps: [
            'घर से निकलें',
            'सड़क तक चलें',
            'बस पकड़ें',
            'बाज़ार में उतरें',
          ],
          hint: 'सफ़र घर से शुरू होता है।',
        ),
      ),
    ),

    // ── Association ───────────────────────────────────────────────
    const CatalogActivity(
      id: 'asso_region_products',
      type: ActivityType.association,
      titleKey: 'activityAssociation',
      subtitleKey: 'assoRegion',
      category: 'region',
      baseDifficulty: Difficulty.comfortable,
      durationSec: 90,
      content: LocalizedContent(
        en: ActivityContent(
          prompt: 'assoRegionPrompt',
          promptEmoji: '🏞️',
          variants: [
            '☕ Tea gardens',
            '🏖️ Sea beach',
            '🏜️ Desert dunes',
            '❄️ Snow peaks',
          ],
          correctLabel: '☕ Tea gardens',
          hint: 'The hills of Assam are famous for green plantations.',
        ),
        hi: ActivityContent(
          prompt: 'assoRegionPrompt',
          promptEmoji: '🏞️',
          variants: [
            '☕ चाय के बागान',
            '🏖️ समुंदर किनारा',
            '🏜️ रेगिस्तान',
            '❄️ बर्फ़ीली चोटियाँ',
          ],
          correctLabel: '☕ चाय के बागान',
          hint: 'असम की पहाड़ियाँ हरी चाय बागानों के लिए मशहूर हैं।',
        ),
      ),
    ),
    const CatalogActivity(
      id: 'asso_harvest_food',
      type: ActivityType.association,
      titleKey: 'activityAssociation',
      subtitleKey: 'assoHarvest',
      category: 'food',
      baseDifficulty: Difficulty.gentle,
      durationSec: 90,
      content: LocalizedContent(
        en: ActivityContent(
          prompt: 'assoHarvestPrompt',
          promptEmoji: '🌾',
          variants: ['🥭 Mango', '🍌 Banana', '🍊 Orange', '🌰 Coconut'],
          correctLabel: '🥭 Mango',
          hint: 'The king of summer fruits, yellow and sweet.',
        ),
        hi: ActivityContent(
          prompt: 'assoHarvestPrompt',
          promptEmoji: '🌾',
          variants: ['🥭 आम', '🍌 केला', '🍊 संतरा', '🌰 नारियल'],
          correctLabel: '🥭 आम',
          hint: 'गर्मी के राजा, पीला और मीठा फल।',
        ),
      ),
    ),

    // ── Attention ─────────────────────────────────────────────────
    const CatalogActivity(
      id: 'attn_find_vegetable',
      type: ActivityType.attention,
      titleKey: 'activityAttention',
      subtitleKey: 'attnVeg',
      category: 'attention',
      baseDifficulty: Difficulty.gentle,
      durationSec: 90,
      content: LocalizedContent(
        en: ActivityContent(
          prompt: 'attnVegPrompt',
          promptEmoji: '🥕',
          variants: ['🥔 Potato', '🌶️ Chilli', '🥕 Carrot', '🧅 Onion'],
          correctLabel: '🥕 Carrot',
          hint: 'It is orange and rabbits love it.',
        ),
        hi: ActivityContent(
          prompt: 'attnVegPrompt',
          promptEmoji: '🥕',
          variants: ['🥔 आलू', '🌶️ मिर्च', '🥕 गाजर', '🧅 प्याज़'],
          correctLabel: '🥕 गाजर',
          hint: 'यह नारंगी है और खरगोश को बहुत पसंद है।',
        ),
      ),
    ),

    // ── Recall (family powered; fallback content if no memories) ──
    const CatalogActivity(
      id: 'recall_family_song',
      type: ActivityType.recall,
      titleKey: 'activityRecall',
      subtitleKey: 'recallSong',
      category: 'memory',
      baseDifficulty: Difficulty.gentle,
      durationSec: 90,
      content: LocalizedContent(
        en: ActivityContent(
          prompt: 'recallSongPrompt',
          promptEmoji: '🎵',
          variants: ['🎶 Bihu song', '🎶 Bhajan', '🎶 Lullaby', '🎶 Film song'],
          correctLabel: '🎶 Bihu song',
          hint: 'Dancers move to it during spring festival.',
        ),
        hi: ActivityContent(
          prompt: 'recallSongPrompt',
          promptEmoji: '🎵',
          variants: ['🎶 बिहू गीत', '🎶 भजन', '🎶 लोरी', '🎶 फ़िल्मी गाना'],
          correctLabel: '🎶 बिहू गीत',
          hint: 'वसंत त्योहार में नर्तक इस पर नाचते हैं।',
        ),
      ),
    ),

    // ── Find the Pairs ────────────────────────────────────────────
    const CatalogActivity(
      id: 'pairs_market_fruits',
      type: ActivityType.pairs,
      titleKey: 'activityPairs',
      subtitleKey: 'pairsFruits',
      category: 'memory',
      baseDifficulty: Difficulty.gentle,
      durationSec: 150,
      content: LocalizedContent(
        en: ActivityContent(
          prompt: 'pairsRemember',
          promptEmoji: '🍓',
          variants: ['🥭 Mango', '🍌 Banana', '🍊 Orange', '🍎 Apple'],
          hint: 'Find two of the very same fruit.',
          images: {
            '🥭 Mango': 'assets/images/pairs/mango.png',
            '🍌 Banana': 'assets/images/pairs/banana.png',
            '🍊 Orange': 'assets/images/pairs/orange.png',
            '🍎 Apple': 'assets/images/pairs/apple.png',
          },
        ),
        hi: ActivityContent(
          prompt: 'pairsRemember',
          promptEmoji: '🍓',
          variants: ['🥭 आम', '🍌 केला', '🍊 संतरा', '🍎 सेब'],
          hint: 'एक जैसे दो फल खोजें।',
          images: {
            '🥭 आम': 'assets/images/pairs/mango.png',
            '🍌 केला': 'assets/images/pairs/banana.png',
            '🍊 संतरा': 'assets/images/pairs/orange.png',
            '🍎 सेब': 'assets/images/pairs/apple.png',
          },
        ),
      ),
    ),
    const CatalogActivity(
      id: 'pairs_kitchen_things',
      type: ActivityType.pairs,
      titleKey: 'activityPairs',
      subtitleKey: 'pairsKitchen',
      category: 'memory',
      baseDifficulty: Difficulty.gentle,
      durationSec: 150,
      content: LocalizedContent(
        en: ActivityContent(
          prompt: 'pairsRemember',
          promptEmoji: '🍶',
          variants: ['🍶 Kettle', '🪭 Hand fan', '🧺 Basket', '🍲 Bowl'],
          hint: 'Find two of the very same thing.',
          images: {
            '🍶 Kettle': 'assets/images/pairs/kettle.png',
            '🪭 Hand fan': 'assets/images/pairs/handfan.png',
            '🧺 Basket': 'assets/images/pairs/basket.png',
            '🍲 Bowl': 'assets/images/pairs/bowl.png',
          },
        ),
        hi: ActivityContent(
          prompt: 'pairsRemember',
          promptEmoji: '🍶',
          variants: ['🍶 चायदानी', '🪭 पंखा', '🧺 टोकरी', '🍲 कटोरा'],
          hint: 'एक जैसी दो चीज़ें खोजें।',
          images: {
            '🍶 चायदानी': 'assets/images/pairs/kettle.png',
            '🪭 पंखा': 'assets/images/pairs/handfan.png',
            '🧺 टोकरी': 'assets/images/pairs/basket.png',
            '🍲 कटोरा': 'assets/images/pairs/bowl.png',
          },
        ),
      ),
    ),

    // ── Remember the Sequence ─────────────────────────────────────
    const CatalogActivity(
      id: 'seq_household_items',
      type: ActivityType.sequenceRecall,
      titleKey: 'activitySequenceRecall',
      subtitleKey: 'seqRecallItems',
      category: 'memory',
      baseDifficulty: Difficulty.comfortable,
      durationSec: 150,
      content: LocalizedContent(
        en: ActivityContent(
          prompt: 'seqRecallWatch',
          promptEmoji: '🧠',
          variants: ['🍶', '🪔', '🧺', '🥄', '🪭', '🍳'],
          hint: 'The order matters – follow the lights.',
        ),
        hi: ActivityContent(
          prompt: 'seqRecallWatch',
          promptEmoji: '🧠',
          variants: ['🍶', '🪔', '🧺', '🥄', '🪭', '🍳'],
          hint: 'क्रम ज़रूरी है – रोशनी का पालन करें।',
        ),
      ),
    ),
    const CatalogActivity(
      id: 'seq_remember_numbers',
      type: ActivityType.sequenceRecall,
      titleKey: 'activitySequenceRecall',
      subtitleKey: 'seqRecallNumbers',
      category: 'memory',
      baseDifficulty: Difficulty.comfortable,
      durationSec: 150,
      content: LocalizedContent(
        en: ActivityContent(
          prompt: 'seqRecallWatch',
          promptEmoji: '🔢',
          variants: ['1', '2', '3', '4', '5', '6'],
          hint: 'Start from the first one you saw.',
        ),
        hi: ActivityContent(
          prompt: 'seqRecallWatch',
          promptEmoji: '🔢',
          variants: ['1', '2', '3', '4', '5', '6'],
          hint: 'जो सबसे पहले देखा उसी से शुरू करें।',
        ),
      ),
    ),

    // ── What Changed? ─────────────────────────────────────────────
    const CatalogActivity(
      id: 'change_market_basket',
      type: ActivityType.findChanged,
      titleKey: 'activityFindChanged',
      subtitleKey: 'changeMarket',
      category: 'memory',
      baseDifficulty: Difficulty.gentle,
      durationSec: 150,
      content: LocalizedContent(
        en: ActivityContent(
          prompt: 'changeRemember',
          promptEmoji: '🧺',
          pairs: [
            MatchPair(left: '🍎 Red apple', right: '🍏 Green apple'),
            MatchPair(left: '🍋 Lemon', right: '🍊 Orange'),
            MatchPair(left: '🍇 Grapes', right: '🫐 Blueberries'),
            MatchPair(left: '🥑 Avocado', right: '🥝 Kiwi'),
            MatchPair(left: '🍑 Peach', right: '🍐 Pear'),
          ],
          hint: 'One fruit in the basket has changed.',
        ),
        hi: ActivityContent(
          prompt: 'changeRemember',
          promptEmoji: '🧺',
          pairs: [
            MatchPair(left: '🍎 लाल सेब', right: '🍏 हरा सेब'),
            MatchPair(left: '🍋 नींबू', right: '🍊 संतरा'),
            MatchPair(left: '🍇 अंगूर', right: '🫐 ब्लूबेरी'),
            MatchPair(left: '🥑 एवोकाडो', right: '🥝 कीवी'),
            MatchPair(left: '🍑 आड़ू', right: '🍐 नाशपाती'),
          ],
          hint: 'टोकरी में एक फल बदल गया है।',
        ),
      ),
    ),
    const CatalogActivity(
      id: 'change_festival_shelf',
      type: ActivityType.findChanged,
      titleKey: 'activityFindChanged',
      subtitleKey: 'changeFestival',
      category: 'festivals',
      baseDifficulty: Difficulty.gentle,
      durationSec: 150,
      content: LocalizedContent(
        en: ActivityContent(
          prompt: 'changeRemember',
          promptEmoji: '🪔',
          pairs: [
            MatchPair(left: '🪔 Diya', right: '🏮 Lantern'),
            MatchPair(left: '🌸 Marigold', right: '🌷 Tulip'),
            MatchPair(left: '✨ Sparkle', right: '🌟 Star'),
            MatchPair(left: '🍬 Sweet', right: '🍭 Lollipop'),
          ],
          hint: 'One lamp on the shelf has changed.',
        ),
        hi: ActivityContent(
          prompt: 'changeRemember',
          promptEmoji: '🪔',
          pairs: [
            MatchPair(left: '🪔 दीया', right: '🏮 लालटेन'),
            MatchPair(left: '🌸 गेंदा', right: '🌷 ट्यूलिप'),
            MatchPair(left: '✨ चमक', right: '🌟 तारा'),
            MatchPair(left: '🍬 मिठाई', right: '🍭 कैंडी'),
          ],
          hint: 'सजावट में एक चीज़ बदल गई है।',
        ),
      ),
    ),
  ];

  static CatalogActivity? byId(String id) {
    for (final a in all) {
      if (a.id == id) return a;
    }
    return null;
  }

  static List<CatalogActivity> byType(ActivityType type) =>
      all.where((a) => a.type == type).toList();
}

/// An activity as defined in the catalog.
class CatalogActivity {
  const CatalogActivity({
    required this.id,
    required this.type,
    required this.titleKey,
    this.subtitleKey,
    required this.category,
    required this.baseDifficulty,
    required this.durationSec,
    required this.content,
  });

  final String id;
  final ActivityType type;
  final String titleKey;
  final String? subtitleKey;
  final String category;
  final Difficulty baseDifficulty;
  final int durationSec;
  final LocalizedContent content;
}
