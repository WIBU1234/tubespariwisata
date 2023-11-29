import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:tubespariwisata/page/firstLanding/loginpage.dart';

void main() {
  testWidgets('Can input username and password', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Loginpage()));

    var usernameField = find.byIcon(Icons.person);
    var passwordField = find.byIcon(Icons.lock);

    await tester.enterText(usernameField, 'testuser');
    await tester.enterText(passwordField, 'testpassword');

    await tester.pump();

    expect(find.text('testuser'), findsOneWidget);
    expect(find.text('testpassword'), findsOneWidget);
  });
}