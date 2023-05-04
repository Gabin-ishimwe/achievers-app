import 'package:achievers_app/firebase_options.dart';
import 'package:achievers_app/screens/long_break_timer.dart';
import 'package:achievers_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  bool isJailbroken = await FlutterJailbreakDetection.jailbroken;

  if (isJailbroken) {
    print("This app cannot run on a jailbroken device.");
    runApp(const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
              "This app cannot run on a Jailbroken or rooted devices have more privileges and enable easy installation of malware and viruses."),
        ),
      ),
    ));
    return;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(LongBreakTimerController());
    return GetMaterialApp(
      title: 'Task Achievers App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      home: const SplashScreen(),
    );
  }
}
