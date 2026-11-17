import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ict135/main.dart';

void main() {
  testWidgets(
      'Login page password toggle, direct Log In, and Log Out navigation',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Lendly'), findsOneWidget);
    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);
    expect(find.text('Sign in with Google'), findsOneWidget);
    expect(find.text("Don't have an account? "), findsOneWidget);
    expect(find.text('Sign up here'), findsOneWidget);

    // Password field starts obscured and toggles visibility when tapped.
    final passwordEditableBefore = tester.widget<EditableText>(
      find.descendant(
        of: find.byType(TextField).at(1),
        matching: find.byType(EditableText),
      ),
    );
    expect(passwordEditableBefore.obscureText, isTrue);

    await tester.tap(find.byIcon(Icons.visibility_outlined));
    await tester.pump();

    final passwordEditableAfter = tester.widget<EditableText>(
      find.descendant(
        of: find.byType(TextField).at(1),
        matching: find.byType(EditableText),
      ),
    );
    expect(passwordEditableAfter.obscureText, isFalse);

    // Clicking Log In even with empty fields goes straight to Blank Home Page.
    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();

    expect(find.text('Lendly'), findsOneWidget);
    expect(find.text('Log Out'), findsOneWidget);
    expect(find.text('Log In'), findsNothing);

    // Clicking Log Out routes straight back to Login Page.
    await tester.tap(find.text('Log Out'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);
  });

  testWidgets('Sign in with Google navigates straight to Blank Home Page',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Sign in with Google'));
    await tester.pumpAndSettle();

    expect(find.text('Lendly'), findsOneWidget);
    expect(find.text('Log Out'), findsOneWidget);
    expect(find.text('Sign in with Google'), findsNothing);
  });

  testWidgets(
      'Sign-Up page Create Account and Log in link route straight to Login Page',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.ensureVisible(find.text('Sign up here'));
    await tester.tap(find.text('Sign up here'));
    await tester.pumpAndSettle();

    expect(find.text('Create your account'), findsOneWidget);
    expect(
      find.text('Send me exclusive deals and product updates'),
      findsOneWidget,
    );
    expect(find.text('Already have an account? '), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);

    // Checkbox toggles cleanly.
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isTrue);
    await tester.ensureVisible(find.byType(Checkbox));
    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, isFalse);

    // Clicking Create Account navigates straight back to Login Page.
    await tester.ensureVisible(find.text('Create Account'));
    await tester.tap(find.text('Create Account'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);

    // Return to Sign-Up Page and tap "Log in" link back to Login Page.
    await tester.ensureVisible(find.text('Sign up here'));
    await tester.tap(find.text('Sign up here'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Log in'));
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
  });

  testWidgets('Layouts render cleanly across mobile and desktop viewports',
      (WidgetTester tester) async {
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final viewports = <Size>[
      const Size(320, 640),
      const Size(375, 812),
      const Size(1280, 800),
    ];

    for (final size in viewports) {
      await tester.binding.setSurfaceSize(size);
      await tester.pumpWidget(MyApp(key: UniqueKey()));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.ensureVisible(find.text('Sign up here'));
      await tester.tap(find.text('Sign up here'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.ensureVisible(find.text('Create Account'));
      await tester.tap(find.text('Create Account'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.ensureVisible(find.text('Sign in with Google'));
      await tester.tap(find.text('Sign in with Google'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    }
  });
}
