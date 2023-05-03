import 'dart:async';
import 'package:achievers_app/screens/session_timer.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../controllers/taskController.dart';
import '../models/task_model.dart';

var taskId;
var completed_sessionss;

class LongBreakTimerController extends GetxController {
  Timer? _timer;
  int remainingSeconds = 0;
  int periodTime = 0;
  var time = '00:00'.obs;
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
      if (remainingSeconds == -1) {
        timer.cancel();
        Task? task = await TaskController.getSingleTask(taskId);
        percentage.value = '1';
        icon.value = Icons.play_arrow;
        running = false;
        remainingSeconds = task!.long_break * 60;
        periodTime = remainingSeconds;
        time.value = "${task.long_break}:00";
        Get.to(TimerScreen(), arguments: {'taskId': taskId});
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

class LongBreakTimerScreen extends StatefulWidget {
  @override
  State<LongBreakTimerScreen> createState() => _LongBreakTimerScreen();
}

class _LongBreakTimerScreen extends State<LongBreakTimerScreen> {
  final timeController = Get.put(LongBreakTimerController());
  IconData icon_value = Icons.play_arrow;

  update_task() async {
    Task? task = await TaskController.getSingleTask(taskId);
    task!.completed_sessions--;
    await TaskController.updateTask(taskId, {
      'completed_sessions': task.completed_sessions,
    });
    timeController.remainingSeconds = task.long_break * 60;
    timeController.percentage.value = '1';
    timeController.icon.value = Icons.play_arrow;
    timeController.running = false;
    timeController.periodTime = timeController.remainingSeconds;
    timeController.time.value = "${task.long_break}:00";
    print(task.completed_sessions);
  }

  @override
  Widget build(BuildContext context) {
    final Map args = Get.arguments;
    taskId = args['taskId'];
    print(taskId);
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
                        onTap: () async {
                          await update_task();
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
                      'Long Break Timer',
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
                  if (task_data.completed_sessions ==
                          task_data.long_break_starts ||
                      timeController.remainingSeconds == 0) {
                    timeController._setProperties(
                      (task_data.long_break * 60),
                      task_data.long_break,
                    );
                  }
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
                                          "${task_data.completed_sessions}/${task_data.working_sessions}",
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
                                    progressColor: Color(0xFF21c064),
                                    backgroundColor: Color(0xFFdef6e8),
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
                                            "Long break",
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
                                    "Take a break for ${task_data.long_break} minutes",
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
                                                          .remainingSeconds =
                                                      task_data.long_break * 60;
                                                  // controller._startTimer();
                                                  timeController.time.value =
                                                      "${task_data.long_break}:00";
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
                                                  timeController
                                                          .remainingSeconds =
                                                      task_data.long_break * 60;
                                                  timeController
                                                      .percentage.value = '1';
                                                  timeController.icon.value =
                                                      Icons.play_arrow;
                                                  timeController.running =
                                                      false;
                                                  timeController.periodTime =
                                                      timeController
                                                          .remainingSeconds;
                                                  timeController.time.value =
                                                      "${task_data.long_break}:00";
                                                  Get.to(TimerScreen(),
                                                      arguments: {
                                                        'taskId': taskId
                                                      });
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
