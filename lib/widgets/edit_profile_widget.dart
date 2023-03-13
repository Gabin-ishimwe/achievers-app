import 'package:achievers_app/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({super.key});

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  var formState = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
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
                                    Icons.add,
                                    color: Colors.white,
                                  )))),
                    ],
                  ),
                  SizedBox(height: 25),
                  //HERE
                  Container(
                    margin: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Form(
                      key: formState,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Full Name",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(.85),
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  prefixIconColor: Color(0xFFC1C1C1),
                                  fillColor: Color(0xFFC1C1C1).withOpacity(0.2),
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
                                  hintText: "Gabin ISHIMWE",
                                  hintStyle: TextStyle(
                                    color: Color(0xFFC1C1C1),
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Preferred Name",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(.85),
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                  prefixIconColor: Color(0xFFC1C1C1),
                                  fillColor: Color(0xFFC1C1C1).withOpacity(0.2),
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
                                  hintText: "Gabin",
                                  hintStyle: TextStyle(
                                    color: Color(0xFFC1C1C1),
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(.85),
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                  prefixIconColor: Color(0xFFC1C1C1),
                                  fillColor: Color(0xFFC1C1C1).withOpacity(0.2),
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
                                  hintText: "g.ishimwe@alustudent.com",
                                  hintStyle: TextStyle(
                                    color: Color(0xFFC1C1C1),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center, 
                              mainAxisAlignment: MainAxisAlignment.center, 
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
                                          fontWeight: FontWeight.normal,
                                          color: Colors.deepPurple),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepPurple[100],
                                        elevation: 0,
                                        padding: const EdgeInsets.all(15),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
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
                                      "Update",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepPurple,
                                        elevation: 0,
                                        padding: const EdgeInsets.all(15),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
