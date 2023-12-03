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
    
  testWidgets("Register login V1 : ", (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MainApp(),
      ),
    );
    await tester.pump();

    var toRegister = find.byKey(const Key('signUpText'));
    await tester.tap(toRegister);
    await tester.pump(const Duration(seconds: 2));

    var usernameField = find.byKey(const Key('usernameField'));
    var emailField = find.byKey(const Key('emailField'));
    var passwordField = find.byKey(const Key('passwordField'));
    var nomorTeleponField = find.byKey(const Key('nomorTeleponField'));
    var tanggalLahirField = find.byKey(const Key('tanggalLahirField'));
    var registerButton = find.byKey(const Key('registerButton'));
    await tester.tap(registerButton);


  });
}