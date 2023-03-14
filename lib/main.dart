import 'package:achievers_app/firebase_options.dart';
import 'package:achievers_app/repositories/auth_repository.dart';
import 'package:achievers_app/screens/home_screen.dart';
import 'package:achievers_app/widgetTree.dart';
import 'package:achievers_app/widgets/home_widget.dart';
import 'package:achievers_app/screens/onboarding_screen.dart';
import 'package:achievers_app/screens/sign_in_screen.dart';
import 'package:achievers_app/screens/sign_up_screen.dart';
import 'package:achievers_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return MaterialApp(
      title: 'Task Achievers App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      // home: StreamBuilder(
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       print("user registered---------------");
      //       print(snapshot.hasData);
      //       return HomeScreen();
      //     } else if (snapshot.hasError) {
      //       print("there is an error");
      //       return Center(
      //         child: Text("there is an error"),
      //       );
      //     } else {
      //       print("user not registered--------------");
      //       return SplashScreen();
      //     }
      //   },
      //   stream: AuthRepository().authStateChanges,
      // ),
      home: WidgetTree(),
    );
  }
}
