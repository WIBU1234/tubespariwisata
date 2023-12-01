import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:tubespariwisata/page/firstLanding/loginpage.dart';
import 'package:tubespariwisata/page/firstLanding/registerpage.dart';

class MockNavigatorObserver extends NavigatorObserver {
  final List<Route<dynamic>> pushedRoutes = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushedRoutes.add(route);
    super.didPush(route, previousRoute);
  }
}

void main() {

  testWidgets('Can input register', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RegisterPage()));

    var usernameField = find.byKey(const Key('usernameField'));
    var emailField = find.byKey(const Key('emailField'));
    var passwordField = find.byKey(const Key('passwordField'));
    var nomorTeleponField = find.byKey(const Key('nomorTeleponField'));
    var tanggalLahirField = find.byKey(const Key('tanggalLahirField'));

    await tester.enterText(usernameField, 'testUsername');
    await tester.enterText(emailField, 'testEmail');
    await tester.enterText(passwordField, 'testPassword');
    await tester.enterText(nomorTeleponField, 'testNomorTelepon');
    await tester.enterText(tanggalLahirField, 'testTanggalLahir');

    await tester.pump();

    expect(find.text('testUsername'), findsOneWidget);
    expect(find.text('testEmail'), findsOneWidget);
    expect(find.text('testPassword'), findsOneWidget);
    expect(find.text('testNomorTelepon'), findsOneWidget);
    expect(find.text('testTanggalLahir'), findsOneWidget);
  });

    testWidgets('Can input register an user', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: RegisterPage()));

    var usernameField = find.byKey(const Key('usernameField'));
    var emailField = find.byKey(const Key('emailField'));
    var passwordField = find.byKey(const Key('passwordField'));
    var nomorTeleponField = find.byKey(const Key('nomorTeleponField'));
    var tanggalLahirField = find.byKey(const Key('tanggalLahirField'));

    await tester.enterText(usernameField, 'testUsername');
    await tester.enterText(emailField, 'testEmail');
    await tester.enterText(passwordField, 'testPassword');
    await tester.enterText(nomorTeleponField, 'testNomorTelepon');
    await tester.enterText(tanggalLahirField, 'testTanggalLahir');

    await tester.pump();

    expect(find.text('testUsername'), findsOneWidget);
    expect(find.text('testEmail'), findsOneWidget);
    expect(find.text('testPassword'), findsOneWidget);
    expect(find.text('testNomorTelepon'), findsOneWidget);
    expect(find.text('testTanggalLahir'), findsOneWidget);

    var button = find.byKey(const Key('registerButton'));
    await tester.tap(button);

    await tester.pumpAndSettle();
  });
}