import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TimerController extends GetxController {
  Timer? _timer;
  int remainingSeconds = 1500;
  final time = '25:00'.obs;
  bool running = false;
  final percentage = '1'.obs;

  @override
  void onReady() {
    // _startTimer(1500);
    super.onReady();
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }

  _startTimer() {
    running = true;
    const duration = Duration(seconds: 1);
    // remainingSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = (remainingSeconds % 60);
        time.value = minutes.toString().padLeft(2, "0") +
            ":" +
            seconds.toString().padLeft(2, "0");
        percentage.value = (remainingSeconds / 1500).toString();
        remainingSeconds--;
      }
    });
  }
}

class SessionTimerScreen extends StatefulWidget {
  @override
  State<SessionTimerScreen> createState() => _SessionTimerScreen();
}

class _SessionTimerScreen extends State<SessionTimerScreen> {
  final controller = Get.put(TimerController());

  IconData icon_value = Icons.play_arrow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                // child: Icon(Icons.arrow_back, color: Colors.black,),
                Text(
                  'Sessions Timer',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )
              ],
            ),
          ),
        ),
        body: Container(
            margin: EdgeInsets.fromLTRB(18, 10, 15, 0),
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF04060F).withOpacity(0.05),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Card(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                        autofocus: false,
                        leading: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            // 'Learn Programming', 0xFF00A9F1, Icons.code, '120 minutes'
                            color: Color(0xFF00A9F1),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.code,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                        title: Text(
                          "Learn Programming",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        subtitle: Text(
                          "120 minutes",
                          style:
                              TextStyle(fontSize: 11, color: Color(0xFF7C7575)),
                        ),
                        trailing: Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          //     decoration: BoxDecoration(
                          //       border: Border.all(width: 1, color: Colors.red),
                          //     ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "1/4",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              Text(
                                "25 minutes",
                                style: TextStyle(
                                    fontSize: 11, color: Color(0xFF7C7575)),
                              ),
                            ],
                          ),
                        ))),
              ),
              Container(
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 50, 0, 40),
                    child: Obx(() => CircularPercentIndicator(
                          radius: 140.0,
                          percent: double.parse(controller.percentage.value),
                          circularStrokeCap: CircularStrokeCap.round,
                          lineWidth: 25.0,
                          progressColor: Color(0xFF00a9f1),
                          backgroundColor: Color(0xFFd9f2fd),
                          center: Container(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(() => Text('${controller.time.value}',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w900,
                                  ))),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 17, 0, 0),
                                child: Text(
                                  "2/4 sessions",
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xFF7C7575)),
                                ),
                              ),
                            ],
                          )),
                        )),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                      child: Center(
                        child: Text(
                          "Stay focused for 25 minutes",
                          style:
                              TextStyle(fontSize: 14, color: Color(0xFF7C7575)),
                        ),
                      )),
                  Container(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(0xFFf0f0f0)),
                              child: Center(
                                  child: IconButton(
                                      icon: const Icon(Icons.refresh),
                                      color: Color(0xFFcccccc),
                                      onPressed: () {
                                        controller._timer!.cancel();
                                        controller.remainingSeconds = 1500;
                                        // controller._startTimer();
                                        controller.time.value = '25:00';
                                        controller.running = false;
                                        controller.percentage.value = '1';
                                        setState(() {
                                          icon_value = Icons.play_arrow;
                                        });
                                      })),
                            ),
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF5F06EE),
                                      Color.fromRGBO(95, 6, 238, 0.75),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )),
                              child: Center(
                                  child: IconButton(
                                      icon: new Icon(icon_value),
                                      color: Colors.white,
                                      onPressed: () {
                                        if (controller.running) {
                                          controller._timer!.cancel();
                                          controller.running = false;
                                          setState(() {
                                            icon_value = Icons.play_arrow;
                                          });
                                        } else {
                                          controller._startTimer();
                                          setState(() {
                                            icon_value = Icons.pause;
                                          });
                                        }
                                      })),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(0xFFf0f0f0)),
                              child: Center(
                                  child: IconButton(
                                      icon: new Icon(Icons.stop),
                                      color: Color(0xFFcccccc),
                                      onPressed: () {
                                        if (controller.running) {
                                          controller._timer!.cancel();
                                          controller.running = false;
                                          setState(() {
                                            icon_value = Icons.play_arrow;
                                          });
                                        }
                                      })),
                            )
                          ]),
                    ),
                  )
                ]),
              )
            ])));
  }
}
