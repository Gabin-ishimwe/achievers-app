import 'dart:async';
import 'package:achievers_app/models/task_model.dart';
import 'package:achievers_app/screens/long_break_timer.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../models/timer_model.dart';
import '../widgets/today_tasks.dart';
import 'package:achievers_app/controllers/taskController.dart';
import 'package:get/get.dart';
import 'package:achievers_app/screens/short_break_timer.dart';

var taskId;
var completed_sessionss;

class TimerController extends GetxController {
  Timer? _timer;
  int remainingSeconds = 0;
  int periodTime = 0;
  var time = '25:00'.obs;
  bool running = false;
  final percentage = '1'.obs;
  var icon = Icons.play_arrow.obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }

  _setProperties(remainingSeconds, time) {
    this.remainingSeconds = remainingSeconds;
    this.periodTime = remainingSeconds;
    this.time.value = "$time:00";
  }

  _startTimer() async {
    running = true;
    const duration = Duration(seconds: 1);
    // remainingSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) async {
      if (remainingSeconds == 0) {
        timer.cancel();

        print('taskId = $taskId');
        Task? task = await TaskController.getSingleTask(taskId);
        task!.completed_sessions++;

        if (task.working_sessions == task.completed_sessions) {
          await TaskController.updateTask(taskId, {
            'completed_sessions': task.completed_sessions,
            'completed': true
          });
        } else {
          await TaskController.updateTask(
              taskId, {'completed_sessions': task.completed_sessions});
          if (task.long_break_starts == task.completed_sessions) {
            Get.to(LongBreakTimerScreen(), arguments: {'taskId': taskId});
          } else {
            Get.to(ShortBreakTimerScreen(), arguments: {'taskId': taskId});
          }
        }
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = (remainingSeconds % 60);
        time.value = minutes.toString().padLeft(2, "0") +
            ":" +
            seconds.toString().padLeft(2, "0");
        percentage.value = (remainingSeconds / periodTime).toString();
        remainingSeconds--;
      }
    });
  }
}

class TimerScreen extends StatefulWidget {
  @override
  State<TimerScreen> createState() => _TimerScreen();
}

class _TimerScreen extends State<TimerScreen> {
  final timeController = Get.put(TimerController());
  IconData icon_value = Icons.play_arrow;

  @override
  Widget build(BuildContext context) {
    // taskId = ModalRoute.of(context)?.settings.arguments as TaskId;
    final Map args = Get.arguments;
    taskId = args['taskId'];
    Future<Task?> task = TaskController.getSingleTask(taskId);
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
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
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
            body: SingleChildScrollView(
                child: FutureBuilder(
              future: task,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var task_data = snapshot.data!;
                  timeController._setProperties(
                    (task_data.working_session_duration * 60),
                    task_data.working_session_duration,
                  );

                  return Container(
                      height: 580, // Set a fixed height
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
                                      color: Color(int.parse(
                                          '0x${task_data.color.toRadixString(16)}')),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        task_data.icon,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    task_data.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                  subtitle: Text(
                                    "${task_data.working_session_duration * task_data.working_sessions} minutes",
                                    style: TextStyle(
                                        fontSize: 11, color: Color(0xFF7C7575)),
                                  ),
                                  trailing: Container(
                                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    //     decoration: BoxDecoration(
                                    //       border: Border.all(width: 1, color: Colors.red),
                                    //     ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${task_data.completed_sessions + 1}/${task_data.working_sessions}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "${task_data.working_session_duration} minutes",
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFF7C7575)),
                                        ),
                                      ],
                                    ),
                                  ))),
                        ),
                        Expanded(
                          child: Column(children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 40, 0, 40),
                              child: Obx(() => CircularPercentIndicator(
                                    radius: 140.0,
                                    percent: double.parse(
                                        timeController.percentage.value),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    lineWidth: 25.0,
                                    progressColor: Color(0xFF00a9f1),
                                    backgroundColor: Color(0xFFd9f2fd),
                                    center: Container(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Obx(() =>
                                            Text('${timeController.time.value}',
                                                style: TextStyle(
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.w900,
                                                ))),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 17, 0, 0),
                                          child: Text(
                                            "${task_data.completed_sessions + 1}/${task_data.working_sessions} sessions",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF7C7575)),
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
                                    "Stay focused for ${task_data.working_session_duration} minutes",
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xFF7C7575)),
                                  ),
                                )),
                            Container(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Color(0xFFf0f0f0)),
                                        child: Center(
                                            child: IconButton(
                                                icon: const Icon(Icons.refresh),
                                                color: Color(0xFFcccccc),
                                                onPressed: () {
                                                  timeController._timer!
                                                      .cancel();
                                                  timeController
                                                      .remainingSeconds = task_data
                                                          .working_session_duration *
                                                      60;
                                                  // controller._startTimer();
                                                  timeController.time.value =
                                                      "${task_data.working_session_duration}:00";
                                                  timeController.running =
                                                      false;
                                                  timeController
                                                      .percentage.value = '1';

                                                  timeController.icon.value =
                                                      Icons.play_arrow;
                                                  // setState(() {
                                                  //   icon_value =
                                                  //       Icons.play_arrow;
                                                  // });
                                                })),
                                      ),
                                      Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFF5F06EE),
                                                Color.fromRGBO(
                                                    95, 6, 238, 0.75),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            )),
                                        child: Center(
                                            child: Obx(() => IconButton(
                                                icon: new Icon(
                                                    timeController.icon.value),
                                                color: Colors.white,
                                                onPressed: () {
                                                  print(timeController.running);
                                                  if (timeController.running) {
                                                    timeController._timer!
                                                        .cancel();
                                                    timeController.running =
                                                        false;
                                                    timeController.icon.value =
                                                        Icons.play_arrow;
                                                  } else {
                                                    timeController
                                                        ._startTimer();
                                                    timeController.icon.value =
                                                        Icons.pause;

                                                    // setState(() {
                                                    //   icon_value = Icons.pause;
                                                    // });
                                                  }
                                                }))),
                                      ),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Color(0xFFf0f0f0)),
                                        child: Center(
                                            child: IconButton(
                                                icon:
                                                    new Icon(Icons.arrow_right),
                                                color: Color(0xFFcccccc),
                                                onPressed: () {
                                                  // if (currentIndex <=
                                                  //     timerContents.length -
                                                  //         1) {
                                                  //   // navigate on another screen
                                                  //   _controller.nextPage(
                                                  //       duration:
                                                  //           const Duration(
                                                  //               milliseconds:
                                                  //                   400),
                                                  //       curve: Curves.ease);
                                                  // }
                                                })),
                                      )
                                    ]),
                              ),
                            )
                          ]),
                        )
                      ]));
                }
                // Check if future is still loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // Handle any errors
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                // Default case
                return Container();
              },
            ))));
  }
}
