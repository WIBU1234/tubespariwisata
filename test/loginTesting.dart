import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tubespariwisata/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

//flutter run test/widgettest.dart

void main() {
  setUpAll(()  {
      HttpOverrides.global = null;
    });
  
  testWidgets("Test login", (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MainApp(),
      ),
    );
    await tester.pump();

    var usernameField = find.byKey(const Key('usernameField'));
    var passwordField = find.byKey(const Key('passwordField'));
    var buttonField = find.byKey(const Key('loginButton'));

    await tester.enterText(usernameField, '123');
    await tester.enterText(passwordField, '123123');
    await tester.tap(buttonField);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.byKey(const Key('homepage')), findsOneWidget);
  });
}