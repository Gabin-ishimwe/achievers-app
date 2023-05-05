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
      await test.enterText(
          find.byKey(const Key("password_key")), "#Password123");
      await test.tap(find.byType(ElevatedButton));
      await test.pump();
      expect(find.text("Invalid Email"), findsOneWidget);
    });
 
    testWidgets("textfields input", (test) async {
      await test.pumpWidget(widgetTree());
      await test.enterText(find.byKey(const Key("email_key")), "gabin@gmail.com");
      await test.enterText(
          find.byKey(const Key("password_key")), "Pass");
      await test.tap(find.byType(ElevatedButton));
      await test.pump();
      expect(find.text("Password must be greater than 6 characters"), findsOneWidget);
    });
 
     testWidgets("textfields input", (test) async {
      await test.pumpWidget(widgetTree());
      await test.enterText(find.byKey(const Key("email_key")), "gabin@gmail.com");
      await test.enterText(
          find.byKey(const Key("password_key")), '');
      await test.tap(find.byType(ElevatedButton));
      await test.pump();
      expect(find.text("Password is required"), findsOneWidget);
    }); 
  });
}