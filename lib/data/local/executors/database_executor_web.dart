import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

/// Web (WebAssembly sqlite3 + drift worker) persistent database.
///
/// The `sqlite3.wasm` and `drift_worker.js` files are served from `web/`
/// (matching the drift release used in `pubspec.lock`).
Future<QueryExecutor> openDatabaseExecutor() async {
  final result = await WasmDatabase.open(
    databaseName: 'companio',
    sqlite3Uri: Uri.parse('sqlite3.wasm'),
    driftWorkerUri: Uri.parse('drift_worker.js'),
  );
  return result.resolvedExecutor;
}

/// Web equivalent used by tests running in a browser.
Future<QueryExecutor> openTestExecutor() async {
  final result = await WasmDatabase.open(
    databaseName: 'companio_test',
    sqlite3Uri: Uri.parse('sqlite3.wasm'),
    driftWorkerUri: Uri.parse('drift_worker.js'),
  );
  return result.resolvedExecutor;
}
