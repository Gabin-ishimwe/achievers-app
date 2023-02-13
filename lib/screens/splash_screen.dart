import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
          child: Image.asset(
        'assets/logo/logo.png',
        height: 100,
        width: 100,
      )),
      backgroundColor: Color(0xFF5F06EE),
    ));
  }
}
