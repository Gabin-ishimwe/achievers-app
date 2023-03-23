import 'package:achievers_app/models/user_model.dart';
import 'package:achievers_app/repositories/auth_repository.dart';
import 'package:achievers_app/repositories/user_repository.dart';
import 'package:achievers_app/screens/sign_in_screen.dart';
import 'package:achievers_app/widgets/edit_profile_widget.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late String? userEmail;
  late Future<UserModel> userProfile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userEmail = AuthRepository().currentUser?.email;
    userProfile = UserRepository().getUserDetails(userEmail!);
  }

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
              child: FutureBuilder(
            future: userProfile,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data!;
                return Column(
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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProfileWidget(
                                                        fullName:
                                                            userData.fullName!,
                                                        email: userData.email!,
                                                        id: userData.id!)));
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      )))),
                        ],
                      ),
                      SizedBox(height: 25),
                      Text(userData.fullName!,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
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
                                Text(userData.fullName!,
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
                                Text(userData.email!,
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
                        showModalBottomSheet(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            context: context,
                            builder: (context) {
                              return Container(
                                  decoration: BoxDecoration(
                                      // color: Colors.deepPurple,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30),
                                          topLeft: Radius.circular(30))),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      SizedBox(height: 20),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text("Logout",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.deepPurple)),
                                      ),
                                      SizedBox(height: 25),
                                      Divider(
                                          indent: 40,
                                          endIndent: 40,
                                          thickness: 2,
                                          color: Colors.black.withOpacity(.20)),
                                      SizedBox(height: 30),
                                      Text("Are you sure you want to logout?",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                                  .withOpacity(.60))),
                                      SizedBox(height: 50),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProfileWidget()));
                                              },
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.deepPurple),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.deepPurple[100],
                                                  elevation: 0,
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50))),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          SizedBox(
                                            width: 150,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                AuthRepository().signOut().then(
                                                    (value) => Navigator
                                                        .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        SignInScreen())));
                                              },
                                              child: Text(
                                                "Logout",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.deepPurple,
                                                  elevation: 0,
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50))),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 80),
                                    ],
                                  ));
                            });
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
        ),
      ),
    );
  }
}
