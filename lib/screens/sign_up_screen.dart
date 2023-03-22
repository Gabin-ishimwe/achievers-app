import 'package:achievers_app/repositories/auth_repository.dart';
import 'package:achievers_app/screens/home_screen.dart';
import 'package:achievers_app/screens/sign_in_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var formState = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var name = TextEditingController();
  bool isChecked = false;
  bool isLoading = false;

  Future<void> signUpWithEmailAndPassword() async {
    try {
      await AuthRepository().createrWithEmailAndPassword(
          emailController.text.trim(), passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: formState,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      splashColor: Colors.transparent,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Create account",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name is required";
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        prefixIconColor: Color(0xFFC1C1C1),
                        fillColor: Color(0xFFC1C1C1).withOpacity(0.2),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        hintText: "Name",
                        hintStyle: TextStyle(
                          color: Color(0xFFC1C1C1),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (!EmailValidator.validate(
                          emailController.text.trim())) {
                        return "Invalid Email";
                      } else if (value!.isEmpty) {
                        return "Email required";
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        prefixIconColor: Color(0xFFC1C1C1),
                        fillColor: Color(0xFFC1C1C1).withOpacity(0.2),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: Color(0xFFC1C1C1),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required";
                      } else if (value.length < 6) {
                        return "Password must be greater than 6 characters";
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        prefixIconColor: Color(0xFFC1C1C1),
                        fillColor: Color(0xFFC1C1C1).withOpacity(0.2),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        hintText: "Password",
                        hintStyle: TextStyle(
                          color: Color(0xFFC1C1C1),
                        )),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          side: BorderSide(color: Colors.deepPurple, width: 2),
                          value: isChecked,
                          onChanged: (newBool) {
                            setState(() {
                              isChecked = newBool!;
                            });
                          }),
                      // Padding(padding: EdgeInsets.only(right: 5)),
                      Text(
                        "Remember me",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formState.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        signUpWithEmailAndPassword().then((value) {
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        }).catchError((e) {
                          setState(() {
                            isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Color.fromARGB(255, 235, 53, 34),
                              behavior: SnackBarBehavior.floating,
                              content: Row(children: [
                                Icon(
                                  Icons.error,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Error occurred, Try again !!!",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ])));
                          // throw e;
                        });
                      }
                    },
                    child: isLoading
                        ? SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                        : Text(
                            "Sign Up",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      Padding(padding: EdgeInsets.only(right: 5)),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInScreen()));
                        },
                        splashColor: Colors.transparent,
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
    ));
  }
}
