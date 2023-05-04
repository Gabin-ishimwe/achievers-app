import 'package:achievers_app/models/task_model.dart';
import 'package:achievers_app/screens/session_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../repositories/task_repository.dart';

class Todo {
  String title;
  var color;
  IconData icon;
  String time;
  Todo(this.title, this.color, this.icon, this.time);
}

class TodayTasksScreen extends StatefulWidget {
  const TodayTasksScreen({super.key});

  @override
  State<TodayTasksScreen> createState() => _TodayTasksScreen();
}

class TaskId {
  final String? id;
  TaskId(this.id);
}

class _TodayTasksScreen extends State<TodayTasksScreen> {
  var all_tasks;
  var length;

  static Future<int> _getTasksLength() async {
    return await Db.allTasks().then((value) {
      return value.length;
    });
  }

  @override
  void initState() {
    all_tasks = Db.allTasks();
    _getTasksLength().then((value) {
      setState(() {
        length = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(getTasks(all_tasks));
    Future<List<Task>> myData = Db.allTasks();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
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
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
              // child: Icon(Icons.arrow_back, color: Colors.black,),
              Text(
                'All tasks ($length)',
                style: const TextStyle(
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
              future: myData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var todos = snapshot.data;

                  return Container(
                      margin: const EdgeInsets.fromLTRB(18, 10, 15, 0),
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: todos?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Get.to(TimerScreen(), arguments: {
                                        'taskId': todos[index].id
                                      });

                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) => TimerScreen(),
                                      //       settings: RouteSettings(
                                      //         arguments:
                                      //             TaskId(todos[index].id),
                                      //       ),
                                      //     ));
                                    },
                                    child: Slidable(
                                      endActionPane: ActionPane(
                                          motion: const DrawerMotion(),
                                          children: [
                                            CustomSlidableAction(
                                              onPressed: ((context) async {
                                                final docUser =
                                                    FirebaseFirestore.instance
                                                        .collection('tasks')
                                                        .doc(todos![index].id);
                                                await docUser.delete();
                                                setState(() {
                                                  myData = Db.allTasks();
                                                  _getTasksLength()
                                                      .then((value) {
                                                    setState(() {
                                                      length = value;
                                                    });
                                                  });
                                                });
                                              }),
                                              // margin: EdgeInsets.fromLTRB(
                                              //     0, 0, 0, 10),
                                              backgroundColor:
                                                  const Color(0xFFffffff),
                                              // foregroundColor: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Container(
                                                height: 47,
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: const Color(
                                                              0xFF04060F)
                                                          .withOpacity(0.05),
                                                      spreadRadius: 3,
                                                      blurRadius: 10,
                                                      offset:
                                                          const Offset(0, 3),
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      const Color(0xFFfddcdd),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.white,
                                                    size: 25,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ]),
                                      child: Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xFF04060F)
                                                    .withOpacity(0.05),
                                                spreadRadius: 3,
                                                blurRadius: 10,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Card(
                                              margin: const EdgeInsets.fromLTRB(
                                                  0, 0, 0, 10),
                                              elevation: 0,
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: ListTile(
                                                  autofocus: false,
                                                  leading: Container(
                                                    height: 45,
                                                    width: 45,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: Color(
                                                          todos?[index].color),
                                                    ),
                                                    child: Center(
                                                      child: Icon(
                                                        todos?[index].icon,
                                                        color: Colors.white,
                                                        size: 25,
                                                      ),
                                                    ),
                                                  ),
                                                  title: Text(
                                                    todos![index].title,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                  ),
                                                  subtitle: Text(
                                                    todos[index].description,
                                                    style: const TextStyle(
                                                        fontSize: 11,
                                                        color:
                                                            Color(0xFF7C7575)),
                                                  ),
                                                  trailing: Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      gradient:
                                                          const LinearGradient(
                                                        colors: [
                                                          Color(0xFF39E180),
                                                          Color(0xFF1AB65C),
                                                        ],
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ),
                                                      // color:Color(0xFF1AB65C),
                                                    ),
                                                    child: const Center(
                                                        child: Icon(
                                                      Icons.play_arrow,
                                                      color: Colors.white,
                                                    )),
                                                  )
                                                  // ),
                                                  ))),
                                    ),
                                  ),
                                ]);
                          }));
                } else {
                  return const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              })),
    );
  }

  // static final _db = FirebaseFirestore.instance;
  // static Future<List<Task>> allTasks() async {
  //   final snapshot = await _db.collection("tasks").get();
  //   var taskData =
  //       snapshot.docs.map((task) => Task.fromSnapshot(task)).toList();

  //   taskData = getTasks(taskData);
  //   print(taskData);
  //   return taskData;
  // }
}
