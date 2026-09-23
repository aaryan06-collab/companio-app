import 'package:flutter_test/flutter_test.dart';

import 'package:companio/core/localization/app_localizations.dart';
import 'package:companio/core/localization/languages.dart';
import 'package:companio/core/localization/strings/strings_as.dart';
import 'package:companio/core/localization/strings/strings_bn.dart';
import 'package:companio/core/localization/strings/strings_brx.dart';
import 'package:companio/core/localization/strings/strings_en.dart';
import 'package:companio/core/localization/strings/strings_grt.dart';
import 'package:companio/core/localization/strings/strings_gu.dart';
import 'package:companio/core/localization/strings/strings_hi.dart';
import 'package:companio/core/localization/strings/strings_kha.dart';
import 'package:companio/core/localization/strings/strings_kn.dart';
import 'package:companio/core/localization/strings/strings_lus.dart';
import 'package:companio/core/localization/strings/strings_ml.dart';
import 'package:companio/core/localization/strings/strings_mni.dart';
import 'package:companio/core/localization/strings/strings_mr.dart';
import 'package:companio/core/localization/strings/strings_ne.dart';
import 'package:companio/core/localization/strings/strings_or.dart';
import 'package:companio/core/localization/strings/strings_pa.dart';
import 'package:companio/core/localization/strings/strings_sat.dart';
import 'package:companio/core/localization/strings/strings_ta.dart';
import 'package:companio/core/localization/strings/strings_te.dart';
import 'package:companio/core/localization/strings/strings_ur.dart';
import 'package:companio/data/content/activity_catalog.dart';
import 'package:companio/data/content/catalog_extras.dart';
import 'package:companio/domain/entities/activity_content.dart';

void main() {
  group('localization dictionaries', () {
    final dictionaries = <String, Map<String, String>>{
      'en': stringsEn,
      'hi': stringsHi,
      'as': stringsAs,
      'bn': stringsBn,
      'brx': stringsBrx,
      'ne': stringsNe,
      'kha': stringsKha,
      'grt': stringsGrt,
      'lus': stringsLus,
      'mni': stringsMni,
      'mr': stringsMr,
      'gu': stringsGu,
      'pa': stringsPa,
      'or': stringsOr,
      'ta': stringsTa,
      'te': stringsTe,
      'kn': stringsKn,
      'ml': stringsMl,
      'ur': stringsUr,
      'sat': stringsSat,
    };

    final supportedCodes = appLanguages.map((l) => l.code).toSet();

    test('every dictionary is registered and resolves', () {
      expect(dictionaries.length, supportedCodes.length);
      for (final code in dictionaries.keys) {
        expect(
          AppLocalizations.hasLanguageCode(code),
          isTrue,
          reason: '$code not registered in the registry',
        );
        final l10n = AppLocalizations.forLanguageCode(code);
        expect(
          l10n.locale.languageCode,
          code,
          reason: '$code resolved to ${l10n.locale.languageCode}',
        );
      }
    });

    test('no dictionary has orphan keys (all keys exist in English)', () {
      for (final entry in dictionaries.entries) {
        if (entry.key == 'en') continue;
        final orphans = entry.value.keys
            .where((k) => !stringsEn.containsKey(k))
            .toList();
        expect(
          orphans,
          isEmpty,
          reason: '${entry.key} has orphan keys: $orphans',
        );
      }
    });

    test('English is the most complete dictionary', () {
      for (final entry in dictionaries.entries) {
        if (entry.key == 'en') continue;
        expect(
          stringsEn.keys.length,
          greaterThanOrEqualTo(entry.value.keys.length),
          reason: '${entry.key} has more keys than English',
        );
      }
      expect(dictionaries.length, greaterThan(1));
    });

    test('normalised and unknown codes resolve safely', () {
      expect(
        AppLocalizations.forLanguageCode('hi-in').locale.languageCode,
        'hi',
      );
      expect(AppLocalizations.forLanguageCode('EN').locale.languageCode, 'en');
      expect(AppLocalizations.forLanguageCode('xx').locale.languageCode, 'en');
      expect(
        AppLocalizations.forLanguageCode('xx').t('appName'),
        stringsEn['appName'],
      );
    });

    test('picker groups reference only supported codes', () {
      for (final code in northEastCodes) {
        expect(
          supportedCodes,
          contains(code),
          reason: 'northEastCodes contains unsupported $code',
        );
      }
      for (final l in appLanguages) {
        expect(languageNameOf(l.code), isNotNull);
      }
    });
  });

  group('activity catalog extras', () {
    test('every overridden activity id exists in the catalog', () {
      for (final id in CatalogExtras.all.keys) {
        expect(
          ActivityCatalog.byId(id),
          isNotNull,
          reason: 'extra content for unknown activity $id',
        );
      }
    });

    test(
      'every supported language either has extras or falls back to English',
      () {
        for (final activity in ActivityCatalog.all) {
          for (final lang in appLanguages) {
            final content = activity.content.forLocale(lang.code);
            expect(content.prompt, isNotNull);
            expect(content.prompt, isNotEmpty);
          }
        }
      },
    );

    test('forLocale returns a fully localised kitchen activity', () {
      final activity = ActivityCatalog.byId('kitchen_chai')!;
      final en = activity.content.forLocale('en');
      expect(en.steps.length, 5);
      for (final lang in appLanguages) {
        final content = activity.content.forLocale(lang.code);
        expect(
          content.steps.length,
          5,
          reason: '${lang.code} should keep 5 kitchen steps',
        );
        expect(content.steps, isNot(contains('')));
      }
    });

    test('field-level merge fills missing fields from English', () {
      const base = ActivityContent(
        prompt: 'promptKey',
        variants: ['A', 'B'],
        steps: ['S1'],
        hint: 'base hint',
      );
      const override = ActivityContent(hint: 'override hint');
      final merged = mergeActivityContent(base, override);
      expect(merged.prompt, 'promptKey');
      expect(merged.variants, orderedEquals(['A', 'B']));
      expect(merged.steps, orderedEquals(['S1']));
      expect(merged.hint, 'override hint');
    });

    test('shopping budget and required products survive the merge', () {
      final shop = ActivityCatalog.byId('shop_bread_milk')!;
      final veg = ActivityCatalog.byId('shop_vegetables')!;
      for (final lang in appLanguages) {
        final bread = shop.content.forLocale(lang.code);
        expect(bread.budget, 100);
        expect(bread.requiredProductIds, containsAll(['milk', 'bread']));
        expect(bread.products, isNotEmpty);

        final greens = veg.content.forLocale(lang.code);
        expect(greens.budget, 60);
        expect(greens.requiredProductIds, containsAll(['potato', 'onion']));
        expect(greens.products, isNotEmpty);
      }
    });

    test(
      'recognition activities keep their correct answer in every language',
      () {
        final activity = ActivityCatalog.byId('attn_find_vegetable')!;
        for (final lang in appLanguages) {
          final content = activity.content.forLocale(lang.code);
          expect(content.correctLabel, isNotNull);
          expect(content.variants, contains(content.correctLabel));
        }
      },
    );

    test('matching activities keep a pair list in every language', () {
      final activity = ActivityCatalog.byId('match_festival_food')!;
      for (final lang in appLanguages) {
        final content = activity.content.forLocale(lang.code);
        expect(content.pairs.length, 4);
        for (final p in content.pairs) {
          expect(p.left, isNotEmpty);
          expect(p.right, isNotEmpty);
        }
      }
    });

    test('find-the-pairs activities keep a full deck in every language', () {
      for (final id in ['pairs_market_fruits', 'pairs_kitchen_things']) {
        final activity = ActivityCatalog.byId(id)!;
        for (final lang in appLanguages) {
          final content = activity.content.forLocale(lang.code);
          expect(
            content.variants.length,
            greaterThanOrEqualTo(4),
            reason: '$id in ${lang.code} needs at least 4 unique cards',
          );
          expect(
            content.variants.where((v) => v.isEmpty),
            isEmpty,
            reason: '$id in ${lang.code} has an empty variant',
          );
          expect(
            content.variants.toSet().length,
            content.variants.length,
            reason: '$id in ${lang.code} must have distinct variants',
          );
        }
      }
    });

    test(
      'remember-the-sequence pools are big enough for the longest round',
      () {
        for (final id in ['seq_household_items', 'seq_remember_numbers']) {
          final activity = ActivityCatalog.byId(id)!;
          for (final lang in appLanguages) {
            final content = activity.content.forLocale(lang.code);
            expect(
              content.variants.length,
              greaterThanOrEqualTo(5),
              reason: '$id in ${lang.code} needs a pool of at least 5',
            );
            expect(
              content.variants.toSet().length,
              content.variants.length,
              reason: '$id in ${lang.code} must have distinct variants',
            );
          }
        }
      },
    );

    test('what-changed keeps a pair list in every language', () {
      for (final id in ['change_market_basket', 'change_festival_shelf']) {
        final activity = ActivityCatalog.byId(id)!;
        for (final lang in appLanguages) {
          final content = activity.content.forLocale(lang.code);
          expect(
            content.pairs.length,
            greaterThanOrEqualTo(4),
            reason: '$id in ${lang.code} needs at least 4 pairs',
          );
          for (final p in content.pairs) {
            expect(p.left, isNotEmpty);
            expect(p.right, isNotEmpty);
            expect(
              p.left,
              isNot(p.right),
              reason: '$id in ${lang.code} must distinguish left/right',
            );
          }
        }
      }
    });

    // ── Guard-rails for the low-resource minority languages ─────────────
    const minorityCodes = {'brx', 'kha', 'grt', 'lus', 'mni', 'sat'};

    // Festival names are proper nouns identical in every language. 'thermos'
    // is a trademark rendered identically in Mizo (Latin script).
    const intentionalLoanBare = {'diwali', 'holi', 'bihu', 'eid', 'thermos'};

    // Strips a leading emoji run (incl. variation selectors / ZWJ) before
    // comparison, so '🥕 Carrot' is read as 'carrot'.
    final emojiPrefix = RegExp(
      r'^[\u{1F000}-\u{1FAFF}\u{2600}-\u{27BF}\u{2B00}-\u{2BFF}\u{FE0F}\u{200D}]+',
      unicode: true,
    );

    /// The content part of a field, emoji stripped and lower-cased.
    String bare(String? value) {
      if (value == null) return '';
      return value.replaceFirst(emojiPrefix, '').trim().toLowerCase();
    }

    /// Digits-only / currency-only values (e.g. '₹20') are language-neutral.
    bool bareNumeric(String value) => !value.contains(RegExp('[a-z]'));

    void auditMinority(
      List<String> problems,
      String lang,
      String activity,
      String field,
      String? minority,
      String? english,
    ) {
      if (minority == null || english == null) return;
      final a = bare(minority);
      if (a.isEmpty || bareNumeric(a) || intentionalLoanBare.contains(a)) {
        return;
      }
      if (a == bare(english)) {
        problems.add(
          '$lang/$activity $field is untranslated English: "$minority"',
        );
      }
    }

    test('minority extras never carry untranslated English content', () {
      final problems = <String>[];
      for (final activity in ActivityCatalog.all) {
        final en = activity.content.en;
        for (final lang in minorityCodes) {
          final extra = activity.content.extra[lang];
          if (extra == null) continue;
          for (var i = 0; i < extra.variants.length; i++) {
            auditMinority(
              problems,
              lang,
              activity.id,
              'variant[$i]',
              extra.variants[i],
              i < en.variants.length ? en.variants[i] : null,
            );
          }
          for (var i = 0; i < extra.pairs.length; i++) {
            auditMinority(
              problems,
              lang,
              activity.id,
              'pair[$i].left',
              extra.pairs[i].left,
              i < en.pairs.length ? en.pairs[i].left : null,
            );
            auditMinority(
              problems,
              lang,
              activity.id,
              'pair[$i].right',
              extra.pairs[i].right,
              i < en.pairs.length ? en.pairs[i].right : null,
            );
          }
          for (var i = 0; i < extra.steps.length; i++) {
            auditMinority(
              problems,
              lang,
              activity.id,
              'step[$i]',
              extra.steps[i],
              i < en.steps.length ? en.steps[i] : null,
            );
          }
          for (var i = 0; i < extra.products.length; i++) {
            auditMinority(
              problems,
              lang,
              activity.id,
              'product[${extra.products[i].id}]',
              extra.products[i].label,
              i < en.products.length ? en.products[i].label : null,
            );
          }
          auditMinority(
            problems,
            lang,
            activity.id,
            'hint',
            extra.hint,
            en.hint,
          );
          auditMinority(
            problems,
            lang,
            activity.id,
            'correctLabel',
            extra.correctLabel,
            en.correctLabel,
          );
        }
      }
      expect(
        problems,
        isEmpty,
        reason:
            'untranslated English leaked into minority content:\n${problems.join('\n')}',
      );
    });

    test('minority dictionaries keep content keys non-English', () {
      const contentKeys = {
        'kitchenBreakfast',
        'kitchenBreakfastHint',
        'kitchenBreakfastPrompt',
        'shopGetMilkBread',
        'shopGetMilkBreadPrompt',
        'shopVeggies',
        'shopVeggiesPrompt',
        'recKitchenItem',
        'recKitchenItemPrompt',
        'recCurrency',
        'matchFestival',
        'matchFestivalPrompt',
        'matchObjectUse',
        'matchObjectUsePrompt',
        'seqMorning',
        'seqMorningPrompt',
        'seqRoute',
        'seqRoutePrompt',
        'assoRegion',
        'assoRegionPrompt',
        'assoHarvest',
        'assoHarvestPrompt',
        'attnVeg',
        'attnVegPrompt',
        'recallSong',
        'recallSongPrompt',
      };
      final problems = <String>[];
      final dicts = <String, Map<String, String>>{
        'brx': stringsBrx,
        'kha': stringsKha,
        'grt': stringsGrt,
        'lus': stringsLus,
        'mni': stringsMni,
        'sat': stringsSat,
      };
      for (final entry in dicts.entries) {
        for (final key in contentKeys) {
          auditMinority(
            problems,
            entry.key,
            'dict',
            key,
            entry.value[key],
            stringsEn[key],
          );
        }
      }
      expect(
        problems,
        isEmpty,
        reason: 'dictionary content keys untranslated:\n${problems.join('\n')}',
      );
    });
  });
}
