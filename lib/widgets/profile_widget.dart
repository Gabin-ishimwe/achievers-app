import 'package:achievers_app/repositories/auth_repository.dart';
import 'package:achievers_app/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
            title: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Image.asset('assets/profile/logo.png'),
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                )),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 20),
                Center(
                    child: Column(children: [
                  CircleAvatar(
                      backgroundImage: AssetImage("assets/profile/gabin.jpeg"),
                      radius: 100.0),
                  SizedBox(height: 25),
                  Text("Gabin Ishimwe",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 0, 20),
                      margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: Column(children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/profile/Badge.png",
                              width: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Gabin ISHIMWE",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Image.asset(
                              "assets/profile/mail.png",
                              width: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("g.ishimwe@lustudent.com",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Image.asset(
                              "assets/profile/joined.png",
                              width: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Joined February 12, 2023",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ])),
                ])),
                // SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    AuthRepository().signOut().then((value) =>
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen())));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 120),
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
