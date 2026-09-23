import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';

/// Native (Android/iOS/desktop) persistent database backed by sqlite3.
Future<QueryExecutor> openDatabaseExecutor() async =>
    driftDatabase(name: 'companio');

/// In-memory sqlite3 database used by unit and widget tests.
Future<QueryExecutor> openTestExecutor() async => NativeDatabase.memory();
