import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:intl/intl.dart';
import 'package:achievers_app/models/task_model.dart';
import 'package:achievers_app/widgets/today_tasks.dart';
import 'package:achievers_app/screens/timer.dart';
import 'package:sticky_headers/sticky_headers.dart';

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
            StickyHeader(
                header: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    padding: EdgeInsets.only(bottom: 10),
                    child: Column(children: [
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
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                    ])),
                content: Column(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    FutureBuilder(
                      future: all_tasks,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var todos = snapshot.data;
                          print(todos);
                          // Map<int, List<Task>> tasksByHour = {};
                          // //group the tasks by hour
                          // for (int i = 0; i < todos!.length; i++) {
                          //   int hour =
                          //       int.parse(todos[i].start_time.split(":")[0]);
                          //   if (!tasksByHour.containsKey(hour)) {
                          //     tasksByHour[hour] = [];
                          //   }
                          //   tasksByHour[hour]!.add(todos[i]);
                          // }

                          Map<String, List<Task>> tasksByHour = {};
                          // group the tasks by hour
                          for (int i = 0; i < todos!.length; i++) {
                            String hour = DateFormat('hh a').format(
                                DateFormat("hh:mm a")
                                    .parse(todos[i].start_time));
                            print(hour);
                            if (!tasksByHour.containsKey(hour)) {
                              tasksByHour[hour] = [];
                            }
                            tasksByHour[hour]!.add(todos[i]);
                          }
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.fromLTRB(18, 18, 15, 0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 24,
                                itemBuilder:
                                    (BuildContext context, int hourIndex) {
                                  DateTime hour =
                                      DateTime(2000, 1, 1, hourIndex + 1);
                                  String formattedHour =
                                      DateFormat('hh a').format(hour);
                                  List<Task> tasks =
                                      tasksByHour[formattedHour] ?? [];
                                  String currentHour = DateFormat('hh:00 a')
                                      .format(DateFormat("hh a")
                                          .parse(formattedHour));
                                  return tasks.isNotEmpty
                                      ? Column(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
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
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          // add a header for each hour
                                          Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(currentHour,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          // add tasks for this hour
                                          ...tasks.map((task) => InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TimerScreen()),
                                                  );
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      10, 0, 10, 5),
                                                  child: Card(
                                                    margin: EdgeInsets.fromLTRB(
                                                        0, 0, 0, 10),
                                                    elevation: 0,
                                                    color: Color(task.color),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: ListTile(
                                                      autofocus: false,
                                                      title: Text(
                                                        task.title,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      subtitle: Text(
                                                        task.start_time,
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                  ]) : SizedBox.shrink();
                                },
                              ));
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                ))
          ],
        ))));
  }
}
