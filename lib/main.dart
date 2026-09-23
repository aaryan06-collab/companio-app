import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/dependencies.dart';
import 'app/companio_app.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // Warm the engine: database, repositories, services, sync + voice.
      await AppDependencies.instance.init();
      AppDependencies.instance.reminderScheduler.start();

      runApp(const ProviderScope(child: CompanioApp()));
    },
    (Object error, StackTrace stack) {
      // Surface startup/async failures (e.g. on web) instead of a silent
      // white screen.
      final message = 'APP UNCAUGHT ERROR: $error\n$stack';
      debugPrint(message);
      // ignore: avoid_print
      print(message);
    },
  );
}
