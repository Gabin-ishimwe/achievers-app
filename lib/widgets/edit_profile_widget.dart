import 'dart:io';
import 'package:achievers_app/models/user_model.dart';
import 'package:achievers_app/repositories/user_repository.dart';
import 'package:achievers_app/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class EditProfileWidget extends StatefulWidget {
  String fullName;
  String email;
  String id;
  final String imageUrl;

  EditProfileWidget(
      {super.key,
      required this.imageUrl,
      required this.fullName,
      required this.email,
      required this.id});

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var formState = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var fullNameController = TextEditingController();
  var preferredNameController = TextEditingController();
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    emailController.text = widget.email;
    fullNameController.text = widget.fullName;
    preferredNameController.text = widget.fullName;
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
                          backgroundImage: _imageFile == null
                              ? NetworkImage(widget.imageUrl) as ImageProvider : FileImage(_imageFile!),
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
                                    showModalBottomSheet(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                              decoration: BoxDecoration(
                                                  // color: Colors.deepPurple,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  30),
                                                          topLeft:
                                                              Radius.circular(
                                                                  30))),
                                              child: Wrap(
                                                alignment: WrapAlignment.center,
                                                children: [
                                                  SizedBox(height: 20),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Text(
                                                        "Select image source",
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            color: Colors
                                                                .deepPurple)),
                                                  ),
                                                  SizedBox(height: 25),
                                                  Divider(
                                                      indent: 40,
                                                      endIndent: 40,
                                                      thickness: 2,
                                                      color: Colors.black
                                                          .withOpacity(.20)),
                                                  SizedBox(height: 30),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 350,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            _takeImage();
                                                          },
                                                          child: Text(
                                                            "Take picture",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .deepPurple),
                                                          ),
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.deepPurple[
                                                                      100],
                                                              elevation: 0,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(15),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50))),
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      SizedBox(
                                                        width: 350,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            _selectImage();
                                                          },
                                                          child: Text(
                                                            "Choose from camera roll",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .deepPurple),
                                                          ),
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor:
                                                                  Colors.deepPurple[
                                                                      100],
                                                              elevation: 0,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(15),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50))),
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                    ],
                                                  ),
                                                ],
                                              ));
                                        });
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
                              controller: fullNameController,
                              decoration: InputDecoration(
                                  prefixIconColor: Color(0xFFC1C1C1),
                                  fillColor: Color(0xFFC1C1C1).withOpacity(0.2),
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
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
                              controller: preferredNameController,
                              decoration: InputDecoration(
                                  prefixIconColor: Color(0xFFC1C1C1),
                                  fillColor: Color(0xFFC1C1C1).withOpacity(0.2),
                                  filled: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none),
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
                                    onPressed: () async {
                                      UserModel userModel = UserModel(
                                          id: widget.id,
                                          fullName: fullNameController.text,
                                          email: emailController.text);
                                      await UserRepository()
                                          .updateUser(userModel);
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

  Future _selectImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        _imageFile = File(pickedFile!.path);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future _takeImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);

      setState(() {
        _imageFile = File(pickedFile!.path);
      });
    } on PlatformException catch (e) {
      print('Failed to take image: $e');
    }
  }
}
