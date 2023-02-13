import 'package:achievers_app/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../models/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  PageController _controller = PageController();

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              // color: Colors.white,
              height: screenHeigth,
              width: screenWidth,
              // padding: EdgeInsets.all(20),
              child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (index) => {
                        print("index ${index}"),
                        if (index == onboardContents.length - 1)
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInScreen()))
                          }
                        else
                          {
                            setState(
                              () {
                                currentIndex = index;
                              },
                            )
                          }
                      },
                  itemCount: onboardContents.length,
                  itemBuilder: (_, index) {
                    return Column(children: [
                      Expanded(
                        flex: 6, // 50 % of screen
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            // color: Colors.red,
                            child: Image.asset(onboardContents[index].image),
                            padding: EdgeInsets.only(left: 20, right: 20),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  onboardContents[index].description,
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      onboardContents.length,
                                      (index) => Container(
                                          height: 10,
                                          width:
                                              currentIndex == index ? 25 : 10,
                                          margin:
                                              const EdgeInsets.only(right: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.deepPurple
                                              // color: const Color.fromARGB(255, 235, 53, 34),
                                              )),
                                    ))
                              ]),
                        ),
                      )
                      //   Container(
                      //   padding: const EdgeInsets.all(20),
                      //   child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.stretch,
                      //       children: [
                      //         Expanded(
                      //           flex: 7,
                      //           child: Container(
                      //             padding: const EdgeInsets.all(15),
                      //             decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(10.0),
                      //               color:
                      //                   const Color.fromARGB(255, 255, 234, 233),
                      //             ),
                      //             child: Column(children: [
                      //               Align(
                      //                 alignment: Alignment.topRight,
                      //                 child: Container(
                      //                   margin: EdgeInsets.zero,
                      //                   padding: EdgeInsets.zero,
                      //                   child: TextButton(
                      //                     onPressed: (() {
                      //                       // skip onboarding
                      //                       // navigate to other screen
                      //                       Navigator.push(context,
                      //                           MaterialPageRoute(
                      //                               builder: ((context) {
                      //                         return const WelcomeScreen();
                      //                       })));
                      //                     }),
                      //                     style: TextButton.styleFrom(
                      //                         padding: const EdgeInsets.all(0),
                      //                         splashFactory:
                      //                             NoSplash.splashFactory),
                      //                     child: Text(
                      //                       "Skip",
                      //                       style: GoogleFonts.poppins(
                      //                           textStyle: const TextStyle(
                      //                         color: Color.fromARGB(
                      //                             255, 235, 53, 34),
                      //                         fontSize: 14,
                      //                       )),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //               Align(
                      //                 alignment: Alignment.center,
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.symmetric(
                      //                       vertical: 10),
                      //                   child: SvgPicture.asset(
                      //                     onboardContents[index].image,
                      //                     semanticsLabel: "logo",
                      //                     height: 250,
                      //                   ),
                      //                 ),
                      //               ),
                      //               const SizedBox(
                      //                 height: 30,
                      //               ),
                      //               Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.center,
                      //                   children: List.generate(
                      //                     onboardContents.length,
                      //                     (index) => Container(
                      //                         height: 10,
                      //                         width:
                      //                             currentIndex == index ? 25 : 10,
                      //                         margin:
                      //                             const EdgeInsets.only(right: 5),
                      //                         decoration: BoxDecoration(
                      //                           borderRadius:
                      //                               BorderRadius.circular(20),
                      //                           color: const Color.fromARGB(
                      //                               255, 235, 53, 34),
                      //                         )),
                      //                   ))
                      //             ]),
                      //           ),
                      //         ),
                      //         Expanded(
                      //             flex: 3,
                      //             child: Padding(
                      //               padding:
                      //                   const EdgeInsets.symmetric(vertical: 15),
                      //               child: Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.stretch,
                      //                   mainAxisSize: MainAxisSize.max,
                      //                   // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //                   children: [
                      //                     Padding(
                      //                       padding: const EdgeInsets.symmetric(
                      //                         horizontal: 20,
                      //                       ),
                      //                       child: Text(
                      //                         onboardContents[index].title,
                      //                         style: GoogleFonts.poppins(
                      //                             textStyle: const TextStyle(
                      //                                 fontSize: 24,
                      //                                 fontWeight:
                      //                                     FontWeight.bold)),
                      //                         textAlign: TextAlign.center,
                      //                       ),
                      //                     ),
                      //                     Padding(
                      //                       padding: const EdgeInsets.symmetric(
                      //                           horizontal: 20, vertical: 5),
                      //                       child: Text(
                      //                         onboardContents[index].description,
                      //                         style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                      //                         textAlign: TextAlign.center,
                      //                       ),
                      //                     ),
                      //                   ]),
                      //             )),
                      //       ]),
                      // ),
                    ]);
                  }),
            )));
  }
}
