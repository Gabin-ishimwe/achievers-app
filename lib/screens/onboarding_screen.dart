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
            body: SizedBox(
              // color: Colors.white,
              height: screenHeigth,
              width: screenWidth,
              // padding: EdgeInsets.all(20),
              child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (index) => {
                        setState(
                          () {
                            currentIndex = index;
                          },
                        )
                      },
                  itemCount: onboardContents.length,
                  itemBuilder: (_, index) {
                    return Column(children: [
                      Expanded(
                        flex: 5, // 50 % of screen
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            // color: Colors.red,
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            // color: Colors.red,
                            child: Image.asset(onboardContents[index].image),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  onboardContents[index].description,
                                  style: const TextStyle(
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
                                    )),
                                ElevatedButton(
                                  onPressed: () {
                                    if (currentIndex ==
                                        onboardContents.length - 1) {
                                      // navigate on another screen
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: ((context) {
                                        return const SignInScreen();
                                      })));
                                    }
                                    _controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 400),
                                        curve: Curves.ease);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      padding: const EdgeInsets.all(15)),
                                  child: Text(
                                    currentIndex == onboardContents.length - 1
                                        ? "Continue"
                                        : "Next",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ]),
                        ),
                      )
                    ]);
                  }),
            )));
  }
}
