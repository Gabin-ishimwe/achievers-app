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
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
              // child: Icon(Icons.arrow_back, color: Colors.black,),
              Text(
                'Edit Profile',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )
            ],
          ),
        ),
      ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 20),
                Center(
                    child: Column(children: [
                  Stack(
                    children: [
                      CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/profile/gabin.jpeg"),
                          radius: 100.0),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle, 
                                color: Colors.deepPurple,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  // do something
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                )
                              ))),
                    ],
                  ),
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
                  onPressed: () {},
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
