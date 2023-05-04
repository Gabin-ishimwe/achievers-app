import 'package:achievers_app/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("sign-in screen", () {
    Widget widgetTree() {
      return const MaterialApp(
        home: SignInScreen(),
      );
    }

    testWidgets("text screen", (test) async {
      await test.pumpWidget(widgetTree());
      expect(find.text("Sign in"), findsOneWidget);
      expect(find.text("Don’t have an account?"), findsOneWidget);
    });

    testWidgets("textfields input", (test) async {
      await test.pumpWidget(widgetTree());
      await test.enterText(find.byKey(const Key("email_key")), "gabin@");
      expect(find.text("Invalid Emai"), findsOneWidget);
      await test.enterText(
          find.byKey(const Key("password_key")), "#Password123");
      await test.tap(find.byType(ElevatedButton));
      // await test.pump();
      // await test.pumpAndSettle(const Duration(milliseconds: 1000));
      expect(find.text("Sign In"), findsNothing);
    });
  });
}
