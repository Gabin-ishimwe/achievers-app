import 'package:achievers_app/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() => null);

  Widget createWidgetTree() {
    return const MaterialApp(
      home: OnboardingScreen(),
    );
  }

  group("Onboarding widget", () {
    testWidgets("text displayed", (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetTree());
      expect(
          find.text("Manage your daily tasks with Achievers"), findsOneWidget);
      expect(find.text("Next"), findsOneWidget);
    });
    testWidgets("click next button", (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetTree());
      var nextPage = find.byType(ElevatedButton);
      await widgetTester.tap(nextPage);
      await widgetTester.pump();
      expect(
          find.text("Manage your daily tasks with Achievers"), findsOneWidget);
    });
  });
}
