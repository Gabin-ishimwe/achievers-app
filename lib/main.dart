import 'package:achievers_app/firebase_options.dart';
import 'package:achievers_app/screens/create_task.dart';
import 'package:achievers_app/screens/splash_screen.dart';
import 'package:achievers_app/widgetTree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:achievers_app/screens/long_break_timer.dart';
import 'package:achievers_app/screens/calendar.dart';
import 'package:achievers_app/widgets/today_tasks.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      home: CalendarPage(),
    );
  }
}
