import "package:achievers_app/repositories/auth_repository.dart";
import "package:achievers_app/screens/create_task.dart";
import "package:achievers_app/screens/home_screen.dart";
import "package:achievers_app/screens/onboarding_screen.dart";
import "package:achievers_app/screens/splash_screen.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("user registered---------------");
            return const HomeScreen();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("there is an error"),
            );
          } else {
            print("user not registered--------------");
            return const OnboardingScreen();
          }
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),
    );
  }
}
