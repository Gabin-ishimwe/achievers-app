import 'package:achievers_app/repositories/auth_repository.dart';
import 'package:achievers_app/screens/complete_daily_task.dart';
import 'package:achievers_app/screens/completion_screen.dart';
import 'package:achievers_app/screens/home_screen.dart';
import 'package:achievers_app/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return OnboardingScreen();
        // return CompletionScreen();
      }));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "assets/logo/logo.png",
            height: 100,
            width: 100,
          ),
          SizedBox(
            height: 100,
          ),
          SpinKitCircle(
            color: Colors.white,
            size: 80.0,
          )
        ]),
      ),
      backgroundColor: Color(0xFF5F06EE),
    ));
  }
}
