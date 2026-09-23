import 'dart:convert';

/// A localized option (also usable for hints/images).
class Option {
  const Option({required this.label, this.emoji = '', this.voice});

  final String label;
  final String emoji;
  final String? voice;

  Map<String, dynamic> toJson() => {
    'label': label,
    'emoji': emoji,
    'voice': voice,
  };

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    label: json['label'] as String,
    emoji: (json['emoji'] as String?) ?? '',
    voice: json['voice'] as String?,
  );
}

/// One matching pair (used by matching-type games).
class MatchPair {
  const MatchPair({required this.left, required this.right});

  final String left;
  final String right;

  Map<String, dynamic> toJson() => {'left': left, 'right': right};

  factory MatchPair.fromJson(Map<String, dynamic> json) => MatchPair(
    left: (json['left'] as String?) ?? '',
    right: (json['right'] as String?) ?? '',
  );
}

/// Product for shopping activities.
class Product {
  const Product({
    required this.id,
    required this.label,
    required this.price,
    this.emoji = '',
  });

  final String id;
  final String label;
  final int price;
  final String emoji;

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'price': price,
    'emoji': emoji,
  };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: (json['id'] as String?) ?? '',
    label: (json['label'] as String?) ?? '',
    price: (json['price'] as num?)?.toInt() ?? 0,
    emoji: (json['emoji'] as String?) ?? '',
  );
}

/// Data-driven activity content. The activity engine renders whatever type
/// is present; unknown types fall back to a gentle recall activity.
class ActivityContent {
  const ActivityContent({
    this.prompt,
    this.variants = const [],
    this.pairs = const [],
    this.steps = const [],
    this.products = const [],
    this.budget = 100,
    this.requiredProductIds = const [],
    this.hint,
    this.correctLabel,
    this.promptEmoji = '',
    this.images = const {},
  });

  /// Main question / instruction.
  final String? prompt;

  /// Either question options (recognition/association/recall/attention)
  /// or grid items (matching). The engine decides by activity type.
  final List<String> variants;

  /// Pairs for the matching game.
  final List<MatchPair> pairs;

  /// Ordered action steps (kitchen/sequence).
  final List<String> steps;

  /// Products for shopping (either pre-defined prices or from variants).
  final List<Product> products;

  /// Shopping budget in rupees.
  final int budget;

  /// Product ids required for a satisfactory shopping result.
  final List<String> requiredProductIds;

  final String? hint;

  /// The "correct" option label for single-answer types.
  final String? correctLabel;

  final String promptEmoji;

  /// Optional asset image per variant (variant label -> asset path). When a
  /// variant has an entry here the game engine renders the picture instead of
  /// the emoji/text label; matching still happens on [variants].
  final Map<String, String> images;

  Map<String, dynamic> toJson() => {
    'prompt': prompt,
    'variants': variants,
    'pairs': pairs.map((e) => e.toJson()).toList(),
    'steps': steps,
    'products': products.map((e) => e.toJson()).toList(),
    'budget': budget,
    'requiredProductIds': requiredProductIds,
    'hint': hint,
    'correctLabel': correctLabel,
    'promptEmoji': promptEmoji,
    'images': images,
  };

  factory ActivityContent.fromJson(Map<String, dynamic> json) =>
      ActivityContent(
        prompt: json['prompt'] as String?,
        variants: ((json['variants'] as List?) ?? const []).cast<String>(),
        pairs: ((json['pairs'] as List?) ?? const [])
            .map((e) => MatchPair.fromJson((e as Map).cast<String, dynamic>()))
            .toList(),
        steps: ((json['steps'] as List?) ?? const []).cast<String>(),
        products: ((json['products'] as List?) ?? const [])
            .map((e) => Product.fromJson((e as Map).cast<String, dynamic>()))
            .toList(),
        budget: (json['budget'] as num?)?.toInt() ?? 100,
        requiredProductIds: ((json['requiredProductIds'] as List?) ?? const [])
            .cast<String>(),
        hint: json['hint'] as String?,
        correctLabel: json['correctLabel'] as String?,
        promptEmoji: (json['promptEmoji'] as String?) ?? '',
        images: ((json['images'] as Map?) ?? const {})
            .map((k, v) => MapEntry(k as String, v as String)),
      );
}

/// Rich, localized activity content: keys map language codes ('en','hi',
/// plus 'extra') to content. For offline storage we keep only the active
/// locale and re-build the catalog in code.
class LocalizedContent {
  const LocalizedContent({required this.en, this.hi, this.extra = const {}});

  final ActivityContent en;
  final ActivityContent? hi;

  /// Raw per-language overrides for languages beyond en/hi. Missing fields
  /// inside an override fall back to [en] via [mergeActivityContent].
  final Map<String, ActivityContent> extra;

  ActivityContent forLocale(String languageCode) {
    final base = languageCode.toLowerCase();
    if (base.startsWith('hi')) return hi ?? en;
    final override = extra[base];
    if (override == null) return en;
    return mergeActivityContent(en, override);
  }
}

/// Field-level merge: every empty/null field of [override] is filled from
/// [base], so a partially translated extra stays readable. Text fields that
/// are deliberately empty cannot suppress a base value.
ActivityContent mergeActivityContent(
  ActivityContent base,
  ActivityContent override,
) => ActivityContent(
  prompt: override.prompt ?? base.prompt,
  variants: override.variants.isNotEmpty ? override.variants : base.variants,
  pairs: override.pairs.isNotEmpty ? override.pairs : base.pairs,
  steps: override.steps.isNotEmpty ? override.steps : base.steps,
  products: override.products.isNotEmpty ? override.products : base.products,
  // Prices are numeric and language-independent; the base always wins.
  budget: base.budget,
  requiredProductIds: override.requiredProductIds.isNotEmpty
      ? override.requiredProductIds
      : base.requiredProductIds,
  hint: override.hint ?? base.hint,
  correctLabel: override.correctLabel ?? base.correctLabel,
  promptEmoji: override.promptEmoji.isNotEmpty
      ? override.promptEmoji
      : base.promptEmoji,
  images: mergeStringMap(base.images, override.images),
);

/// Field-level merge for [ActivityContent.images]: entries from [override]
/// win, everything else falls back to [base].
Map<String, String> mergeStringMap(
  Map<String, String> base,
  Map<String, String> override,
) => {...base, ...override};

/// Maps an activity id to its translated content for one language.
typedef ActivityExtras = Map<String, ActivityContent>;

/// Serialization helpers shared by services.
abstract final class JsonUtil {
  static String encode(Object? value) => jsonEncode(value);

  static T decode<T>(
    String? raw,
    T Function(Map<String, dynamic>) builder,
    Map<String, dynamic> fallback,
  ) {
    if (raw == null || raw.isEmpty) return builder(fallback);
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) return builder(decoded);
      return builder(fallback);
    } catch (_) {
      return builder(fallback);
    }
  }
}
