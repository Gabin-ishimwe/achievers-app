import 'package:achievers_app/firebase_options.dart';
import 'package:achievers_app/helpers/notification.dart';
import 'package:achievers_app/screens/long_break_timer.dart';
import 'package:achievers_app/screens/session_timer.dart';
import 'package:achievers_app/screens/sign_in_screen.dart';
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
              "This app is not compatible with jailbroken or rooted devices. Jailbreaking or rooting a device removes certain restrictions imposed by the operating system, granting users more control and access to system files. By running this app on a jailbroken or rooted device, you could be putting your device and personal information at risk. Therefore, we highly recommend using this app only on devices that have not been jailbroken or rooted."),
        ),
      ),
    ));
    return;
  }
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
    Get.to(const TimerScreen(), arguments: {'taskId': payload});
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
      home: const SplashScreen(),
    );
  }
}
