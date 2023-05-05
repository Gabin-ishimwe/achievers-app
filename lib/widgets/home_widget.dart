import 'package:achievers_app/models/task_model.dart';
import 'package:achievers_app/models/user_model.dart';
import 'package:achievers_app/screens/session_timer.dart';
import 'package:achievers_app/widgets/today_tasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../repositories/auth_repository.dart';
import '../repositories/task_repository.dart';
import '../repositories/user_repository.dart';

class Todo {
  String title;
  var color;
  IconData icon;
  String time;
  Todo(this.title, this.color, this.icon, this.time);
}

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidget();
}

class _HomeScreenWidget extends State<HomeScreenWidget> {
  late Future<List<Task>> incompleted_tasks;
  late Future<List<Task>> all_tasks;
  late Future<HomeVariable> home_vars;

  final userLoggedIn = AuthRepository().currentUser?.email;
  late Future<UserModel> user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = UserRepository().getUserDetails(userLoggedIn!);
    incompleted_tasks = Db.filterTasks("completed", false);
    all_tasks = Db.allTasks();
    home_vars = Db.getHomeVariables();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Image.asset('assets/profile/logo.png'),
              ),
              const Text(
                'Achievers',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(18, 18, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FutureBuilder(
                  future: user,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var userDetils = snapshot.data;
                      return Text('Welcome, ${userDetils!.fullName} 😊',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              color: Colors.black));
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              FutureBuilder(
                  future: home_vars,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var stats = snapshot.data;
                      return Container(
                          margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                          width: MediaQuery.of(context).size.width,
                          height: 140,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF04060F).withOpacity(0.05),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ]),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: CircularPercentIndicator(
                                  radius: 50.0,
                                  percent: stats!.percentage / 100,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  lineWidth: 15.0,
                                  progressColor: const Color(0xFF5F06EE),
                                  backgroundColor: const Color(0xFFe7dafc),
                                  center: Text(
                                    '${stats.percentage.round()}%',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  // width: 210,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Almost there! Keep pushing 💪",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 16,
                                                color: Colors.black)),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 10)),
                                        Text(
                                          "${stats.completed} 0f ${stats.totalTasks} completed!",
                                          style: TextStyle(
                                              color: Color(0xFF7C7575),
                                              fontSize: 12),
                                        ),
                                      ]),
                                ),
                              ),
                              // )
                            ],
                          ));
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              FutureBuilder(
                future: incompleted_tasks,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var todos = snapshot.data;
                    print(todos);
                    var number_of_tasks = todos?.length;

                    return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        // margin: EdgeInsets.fromLTRB(18, 18, 15, 0),
                        child: Column(children: [
                          Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Today’s incompleted tasks ($number_of_tasks)',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TodayTasksScreen()));
                                      },
                                      child: const Text('See All Tasks',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF5F06EE))))
                                ],
                              )),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: todos?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          Get.to(TimerScreen(), arguments: {
                                            'taskId': todos[index].id
                                          });
                                        },
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
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 10),
                                                elevation: 0,
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: ListTile(
                                                    autofocus: false,
                                                    leading: Container(
                                                      height: 45,
                                                      width: 45,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: Color(
                                                            todos?[index]
                                                                .color),
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
                                                          color: Color(
                                                              0xFF7C7575)),
                                                    ),
                                                    trailing: Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
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
                                      )
                                    ]);
                              })
                        ]));
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
