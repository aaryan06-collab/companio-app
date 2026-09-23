import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:companio/app/dependencies.dart';
import 'package:companio/app/companio_app.dart';
import 'package:companio/app/providers.dart';
import 'package:companio/core/utilities/password_hasher.dart';
import 'package:companio/data/local/app_database.dart';
import 'package:companio/features/caregiver/caregiver_shell.dart';
import 'package:companio/shared/widgets/language_picker.dart';

void main() {
  late AppDependencies deps;

  setUp(() async {
    deps = AppDependencies(
      database: await AppDatabase.connectForTesting(),
      deviceId: 'test-device',
      reachability: () async => false,
    );
  });

  tearDown(() {
    deps.reminderScheduler.stop();
    deps.syncService.stop();
  });

  testWidgets('fresh install opens the welcome page with sign-up and login', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [depsProvider.overrideWithValue(deps)],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const CompanioApp(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.byKey(const ValueKey('signup-username')), findsNothing);
    expect(find.byIcon(Icons.person_add_rounded), findsOneWidget);
    expect(find.byIcon(Icons.login_rounded), findsOneWidget);

    await tester.tap(find.byIcon(Icons.person_add_rounded));
    await tester.pump();
    expect(find.byKey(const ValueKey('signup-username')), findsOneWidget);

    deps.syncService.stop();
    deps.reminderScheduler.stop();
  });

  testWidgets('caregiver sign-up opens the caregiver shell', (tester) async {
    final container = ProviderContainer(
      overrides: [depsProvider.overrideWithValue(deps)],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const CompanioApp(),
      ),
    );
    final session = await container.read(sessionProvider.future);
    expect(session, isNull);

    await container
        .read(sessionProvider.notifier)
        .signUpCaregiver(
          username: 'rohan',
          password: 'secret123',
          name: 'Rohan',
        );
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(CaregiverShell), findsOneWidget);
    expect(find.byKey(const ValueKey('signup-username')), findsNothing);

    deps.syncService.stop();
    deps.reminderScheduler.stop();
  });

  testWidgets('caregiver profile tab switches the app language live', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [depsProvider.overrideWithValue(deps)],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const CompanioApp(),
      ),
    );
    await deps.init();
    await container
        .read(sessionProvider.notifier)
        .signUpCaregiver(
          username: 'rohan',
          password: 'secret123',
          name: 'Rohan',
        );
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.byType(CaregiverShell), findsOneWidget);

    // Profile lives in the "More" sheet on compact screens.
    await tester.tap(find.byIcon(Icons.more_horiz_rounded));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    // Language section is visible (Hindi is the default app language).
    expect(find.byType(LanguagePicker), findsOneWidget);
    expect(find.text('ऐप की भाषा'), findsOneWidget);

    // Switch to English.
    await tester.tap(find.widgetWithText(ChoiceChip, 'English'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text('App language'), findsOneWidget);

    deps.syncService.stop();
    deps.reminderScheduler.stop();
  });

  test('password hashing round-trips', () async {
    await deps.init();
    final hash = PasswordHasher.hash('secret123');
    expect(hash, isNot(contains('secret123')));
    expect(PasswordHasher.verify('secret123', hash), isTrue);
    expect(PasswordHasher.verify('wrongpass', hash), isFalse);
    expect(PasswordHasher.verify('secret123', 'garbage'), isFalse);
  });
}
