import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:intl/intl.dart';
import 'package:achievers_app/models/task_model.dart';
import 'package:achievers_app/widgets/today_tasks.dart';
import 'package:achievers_app/screens/timer.dart';


class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate = DateTime.now();

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _onMonthChange(DateTime firstDayOfNewMonth) {
    _selectDate(firstDayOfNewMonth);
  }

  late Future<List<Task>> all_tasks;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    all_tasks = Db.allTasks() as Future<List<Task>>;
  }

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
                child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(
                        _selectedDate.year,
                        _selectedDate.month - 1,
                        1,
                      );
                      _onMonthChange(_selectedDate);
                    });
                  },
                ),
                Text(
                  DateFormat('MMMM yyyy').format(_selectedDate),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(
                        _selectedDate.year,
                        _selectedDate.month + 1,
                        1,
                      );
                      _onMonthChange(_selectedDate);
                    });
                  },
                ),
              ],
            ),
            Container(
              height: 95,
              margin: EdgeInsets.fromLTRB(13, 15, 0, 0),
              child: DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.deepPurple,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  _selectDate(date);
                },
              ),
            ),
            FutureBuilder(
              future: all_tasks,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var todos = snapshot.data;
                  print(todos);
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      // margin: EdgeInsets.fromLTRB(18, 18, 15, 0),
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TimerScreen()));
                                    },
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
                                                  todos[index].description,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Color(0xFF7C7575)),
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
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
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
                                  )
                                ]);
                          }));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ))));
  }
}
