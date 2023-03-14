import 'package:achievers_app/firebase_options.dart';
import 'package:achievers_app/screens/home_screen.dart';
import 'package:achievers_app/widgets/home_widget.dart';
import 'package:achievers_app/screens/onboarding_screen.dart';
import 'package:achievers_app/screens/sign_in_screen.dart';
import 'package:achievers_app/screens/sign_up_screen.dart';
import 'package:achievers_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:achievers_app/screens/session_timer.dart';
import 'package:achievers_app/screens/short_break_timer.dart';
import 'package:achievers_app/screens/long_break_timer.dart';
import 'package:achievers_app/screens/timer.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(LongBreakTimerController());
    return MaterialApp(
      title: 'Task Achievers App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      home: HomeScreen(),
    );
  }
}