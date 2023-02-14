import 'package:achievers_app/screens/home.dart';
import 'package:achievers_app/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Achievers App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          textTheme:
              GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      home: HomeScreen(),
    );
  }
}
