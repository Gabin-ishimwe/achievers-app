import 'package:flutter/material.dart';

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

class _TodayTasksScreen extends State<TodayTasksScreen> {
  List<Todo> todos = [
    Todo('Learn Programming', 0xFF00A9F1, Icons.code, '120 minutes'),
    Todo('Working out', 0xFFF54336, Icons.fitness_center, '45 minutes'),
    Todo('Meditating', 0xFF8BC255, Icons.self_improvement, '15 minutes'),
    Todo('Work On Assignment', 0xFF607D8A, Icons.assignment, '120 minutes'),
    Todo('Listen To Music', 0xFFFFC02D, Icons.headset, '30 minutes'),
    Todo('Learn Programming', 0xFF00A9F1, Icons.code, '120 minutes'),
    Todo('Working out', 0xFFF54336, Icons.fitness_center, '45 minutes'),
    Todo('Meditating', 0xFF8BC255, Icons.self_improvement, '15 minutes'),
    Todo('Work On Assignment', 0xFF607D8A, Icons.assignment, '120 minutes'),
    Todo('Listen To Music', 0xFFFFC02D, Icons.headset, '30 minutes'),
  ];

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
                'Today’s tasks (10)',
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
          child: Container(
              margin: EdgeInsets.fromLTRB(18, 10, 15, 0),
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: todos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                          decoration: BoxDecoration(
                          boxShadow: [
                          BoxShadow(
                            color: Color(0xFF04060F).withOpacity(0.05),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),],),
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
                                      color: Color(todos[index].color),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        todos[index].icon,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    todos[index].title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16,color: Colors.black),
                                  ),
                                  subtitle: Text(
                                    todos[index].time,
                                    style: TextStyle(
                                        fontSize: 11, color: Color(0xFF7C7575)),
                                  ),
                                  trailing: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF39E180),
                                          Color(0xFF1AB65C),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
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
                        ]);
                  }))),
    );
  }
}
