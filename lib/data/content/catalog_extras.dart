import '../../domain/entities/activity_content.dart';
import 'catalog_extras/extras_as.dart';
import 'catalog_extras/extras_bn.dart';
import 'catalog_extras/extras_brx.dart';
import 'catalog_extras/extras_grt.dart';
import 'catalog_extras/extras_gu.dart';
import 'catalog_extras/extras_kha.dart';
import 'catalog_extras/extras_kn.dart';
import 'catalog_extras/extras_lus.dart';
import 'catalog_extras/extras_ml.dart';
import 'catalog_extras/extras_mni.dart';
import 'catalog_extras/extras_mr.dart';
import 'catalog_extras/extras_ne.dart';
import 'catalog_extras/extras_or.dart';
import 'catalog_extras/extras_pa.dart';
import 'catalog_extras/extras_sat.dart';
import 'catalog_extras/extras_ta.dart';
import 'catalog_extras/extras_te.dart';
import 'catalog_extras/extras_ur.dart';

/// Aggregates every per-language catalog override into one map, keyed by
/// activity id, then by language code. `ActivityCatalog` attaches the slice
/// for each activity to its `LocalizedContent.extra`.
abstract final class CatalogExtras {
  static final Map<String, ActivityExtras> all = _build();

  static Map<String, ActivityExtras> _build() {
    final byActivity = <String, ActivityExtras>{};
    void add(String language, Map<String, ActivityContent> languageMap) {
      languageMap.forEach((activityId, content) {
        byActivity.putIfAbsent(
          activityId,
          () => <String, ActivityContent>{},
        )[language] = content;
      });
    }

    add('as', extrasAs);
    add('bn', extrasBn);
    add('brx', extrasBrx);
    add('ne', extrasNe);
    add('kha', extrasKha);
    add('grt', extrasGrt);
    add('lus', extrasLus);
    add('mni', extrasMni);
    add('sat', extrasSat);
    add('mr', extrasMr);
    add('gu', extrasGu);
    add('pa', extrasPa);
    add('or', extrasOr);
    add('ta', extrasTa);
    add('te', extrasTe);
    add('kn', extrasKn);
    add('ml', extrasMl);
    add('ur', extrasUr);
    return byActivity;
  }
}
