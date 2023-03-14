import 'package:achievers_app/widgets/hover_card.dart';
import 'package:achievers_app/widgets/today_tasks.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:achievers_app/models/todo_model.dart';

class HomeScreenWidget extends StatefulWidget {
  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidget();
}

class _HomeScreenWidget extends State<HomeScreenWidget> {
  List<TodoTask> todos = [
    TodoTask('Learn Programming', 0xFF00A9F1, Icons.code, '120 minutes'),
    TodoTask('Working out', 0xFFF54336, Icons.fitness_center, '45 minutes'),
    TodoTask('Meditating', 0xFF8BC255, Icons.self_improvement, '15 minutes'),
    TodoTask('Work On Assignment', 0xFF607D8A, Icons.assignment, '120 minutes'),
    TodoTask('Listen To Music', 0xFFFFC02D, Icons.headset, '30 minutes'),
  ];

  bool isHovering = false;

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
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Image.asset('assets/profile/logo.png'),
              ),
              Text(
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
          margin: EdgeInsets.fromLTRB(18, 18, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Welcome, Gabin 😊',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Colors.black),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                  width: MediaQuery.of(context).size.width,
                  height: 140,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF04060F).withOpacity(0.05),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ]),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: CircularPercentIndicator(
                          radius: 50.0,
                          percent: 0.8,
                          circularStrokeCap: CircularStrokeCap.round,
                          lineWidth: 15.0,
                          progressColor: Color(0xFF5F06EE),
                          center: Text(
                            '80%',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          // width: 210,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Almost there! Keep pushing 💪",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16,
                                        color: Colors.black)),
                                Padding(padding: EdgeInsets.only(bottom: 10)),
                                Text(
                                  "8 0f 10 completed!",
                                  style: TextStyle(
                                      color: Color(0xFF7C7575), fontSize: 12),
                                ),
                              ]),
                        ),
                      ),
                      // )
                    ],
                  )),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today’s tasks (10)',
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
                                    builder: (context) => TodayTasksScreen()));
                          },
                          child: Text('See All Tasks',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFF5F06EE))))
                    ],
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  // margin: EdgeInsets.fromLTRB(18, 18, 15, 0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: todos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              HoverCard(task: todos[index]),
                            ]);
                      })),
            ],
          ),
        ),
      ),
      // ignore: unnecessary_new
      //     bottomNavigationBar: new Theme(
      // data: Theme.of(context).copyWith(
      //     // sets the background color of the `BottomNavigationBar`
      //     canvasColor: Colors.white,
      //     // sets the active color of the `BottomNavigationBar` if `Brightness` is light
      //     primaryColor: Color(0xFF5F06EE),
      //     textTheme: Theme
      //         .of(context)
      //         .textTheme
      //         .copyWith(caption: new TextStyle(color:Color(0xFF7C7575)), ),),

      //       child: BottomNavigationBar(
      //       type: BottomNavigationBarType.fixed,
      //       currentIndex: 0,
      //       items: [
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.home),
      //           label: 'Home',

      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.calendar_today),
      //           label: 'Tasks',
      //         ),
      //         BottomNavigationBarItem(
      //           icon: CircleAvatar(child: Icon(Icons.add)), label: ''),
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.insert_chart),
      //           label: 'Statistics',
      //         ),
      //         BottomNavigationBarItem(
      //           icon: Icon(Icons.account_circle),
      //           label: 'Profile',
      //         ),
      //       ],
      //     ))
    );
  }
}
