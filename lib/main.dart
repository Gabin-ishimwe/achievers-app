import 'package:achievers_app/firebase_options.dart';
import 'package:achievers_app/helpers/notification.dart';
import 'package:achievers_app/screens/session_timer.dart';
import 'package:achievers_app/screens/splash_screen.dart';
import 'package:achievers_app/widgetTree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:achievers_app/screens/long_break_timer.dart';
import 'package:achievers_app/screens/calendar.dart';
import 'package:achievers_app/widgets/today_tasks.dart';
import 'package:achievers_app/widgets/create_task_widget.dart';
import 'package:achievers_app/screens/create_task.dart';
import 'package:achievers_app/screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    NotificationClass.init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() {
    NotificationClass.onNotifications.stream.listen(onClickedNotification);
  }

  void onClickedNotification(String? payload) {
    Get.to(TimerScreen(), arguments: {'taskId': payload});
  }

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
      home: SignInScreen(),
    );
  }
}
