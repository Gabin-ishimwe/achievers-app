import 'package:achievers_app/models/task_model.dart';
import 'package:achievers_app/screens/timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class Todo {
  String title;
  var color;
  IconData icon;
  String time;
  Todo(this.title, this.color, this.icon, this.time);
}

class TodayTasksScreen extends StatefulWidget {
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
    // TODO: implement initState
    // Db.allTasks().then((value) {
    //   all_tasks = Db.allTasks();
    // }).catchError((err) => print(err));
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
    Future<List<Task>> _myData = Db.allTasks();
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
                'All tasks (${length})',
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
              future: _myData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var todos = snapshot.data;

                  return Container(
                      margin: EdgeInsets.fromLTRB(18, 10, 15, 0),
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: todos?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {        
                                      Get.to(TimerScreen(), arguments: {'taskId': todos[index].id});

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
                                          motion: DrawerMotion(),
                                          children: [
                                            CustomSlidableAction(
                                              onPressed: ((context) async {
                                                final docUser =
                                                    FirebaseFirestore.instance
                                                        .collection('tasks')
                                                        .doc(todos![index].id);
                                                await docUser.delete();
                                                setState(() {
                                                  _myData = Db.allTasks();
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
                                                  Color(0xFFffffff),
                                              // foregroundColor: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Container(
                                                height: 47,
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0xFF04060F)
                                                          .withOpacity(0.05),
                                                      spreadRadius: 3,
                                                      blurRadius: 10,
                                                      offset: Offset(0, 3),
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Color(0xFFfddcdd),
                                                ),
                                                child: Center(
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
                                                color: Color(0xFF04060F)
                                                    .withOpacity(0.05),
                                                spreadRadius: 3,
                                                blurRadius: 10,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Card(
                                              margin: EdgeInsets.fromLTRB(
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
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                  ),
                                                  subtitle: Text(
                                                    todos![index].description,
                                                    style: TextStyle(
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
                                                      gradient: LinearGradient(
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
                                                    child: Center(
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
                  return Padding(
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

class Db {
  static var categories = {
    "code": {
      'color': 0xFF00A9F1,
      'icon': Icons.code,
    },
    "health": {'color': 0xFFF54336, 'icon': Icons.fitness_center},
    "leisure": {
      'color': 0xFF8BC255,
      'icon': Icons.self_improvement,
    },
    "school": {'color': 0xFF607D8A, 'icon': Icons.assignment},
    "entertainment": {'color': 0xFFFFC02D, 'icon': Icons.headset},
  };

  static final _db = FirebaseFirestore.instance;
  static Future<List<Task>> allTasks() async {
    final snapshot = await _db.collection("userTasks").get();
    var taskData =
        snapshot.docs.map((task) => Task.fromSnapshot(task)).toList();

    taskData = getTasks(taskData);
    print(taskData);
    return taskData;
  }

  static List<Task> getTasks(List<Task> the_tasks) {
    var new_asks_array = the_tasks.map((Task task) {
      task.color = categories[task.category]!["color"];
      task.icon = categories[task.category]!["icon"];
      print("compute-----------");
      return task;
    }).toList();
    return new_asks_array;
  }
}
