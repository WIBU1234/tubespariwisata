import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mocking/main.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:tubespariwisata/page/firstLanding/loginpage.dart';

class MockNavigatorObserver extends NavigatorObserver {
  final List<Route<dynamic>> pushedRoutes = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushedRoutes.add(route);
    super.didPush(route, previousRoute);
  }
}

void main() {
  testWidgets('Can input username and password', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Loginpage()));

    var usernameField = find.byKey(const Key('usernameField'));
    var passwordField = find.byKey(const Key('passwordField'));

    await tester.enterText(usernameField, 'testUsername');
    await tester.enterText(passwordField, 'testPassword');

    await tester.pump();

    expect(find.text('testUsername'), findsOneWidget);
    expect(find.text('testPassword'), findsOneWidget);
  });

  testWidgets('Can tap login button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: Loginpage()));

    var usernameField = find.byKey(const Key('usernameField'));
    var passwordField = find.byKey(const Key('passwordField'));
    var loginButton = find.byKey(const Key('loginButton'));

    await tester.enterText(usernameField, 'testUsername');
    await tester.enterText(passwordField, 'testPassword');

    await tester.pump();

    await tester.tap(loginButton);
    await tester.pump();

    await tester.pumpAndSettle();
    expect(find.text('Login failed. Please check your credentials.'), findsOneWidget);
  });

  testWidgets('Login as User', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();

    await tester.pumpWidget(MaterialApp(
      home: const Loginpage(),
      navigatorObservers: [mockObserver],
    ));

    var usernameField = find.byKey(const Key('usernameField'));
    var passwordField = find.byKey(const Key('passwordField'));
    var loginButton = find.byKey(const Key('loginButton'));

    await tester.enterText(usernameField, '12');
    await tester.enterText(passwordField, '121212');

    await tester.pump();

    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    Route<dynamic> lastRoute = mockObserver.pushedRoutes.last;
    expect(lastRoute.settings.name, 'HomePage');

    expect(find.text('Welcome, 2 !'), findsOneWidget);
  });
}