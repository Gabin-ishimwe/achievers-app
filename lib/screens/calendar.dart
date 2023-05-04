import 'package:achievers_app/models/task_model.dart';
import 'package:achievers_app/screens/session_timer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../repositories/task_repository.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

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

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    all_tasks = Db.allTasks();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Scroll to today's date after the page has finished building
      _scrollToToday();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToToday() {
    final today = DateTime.now();
    final todayPosition = (today.day - 1) * 60.0;
    _scrollController.animateTo(
      todayPosition,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
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
                child: Column(
          children: [
            StickyHeader(
                header: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF04060F).withOpacity(0.05),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.deepPurple,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.white),
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
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
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
                      ),
                      Container(
                        height: 95,
                        margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                        child: ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: 31,
                          itemBuilder: (context, index) {
                            final date = DateTime(
                              _selectedDate.year,
                              _selectedDate.month,
                              index + 1,
                            );
                            final now = DateTime.now();
                            final isSelected = date == _selectedDate;
                            final isSelectedToday = isSameDay(date, now);

                            // DateTime seldate = DateTime(date);
                            final dayName = DateFormat.E().format(date);
                            return GestureDetector(
                                onTap: () => _selectDate(date),
                                child: Container(
                                  width: 60,
                                  margin: const EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.deepPurple,
                                      width: isSelectedToday ? 2 : 1,
                                    ),
                                    color: isSelectedToday
                                        ? Colors.deepPurple.shade100
                                        : isSelected
                                            ? Colors.deepPurple
                                            : null,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${index + 1}',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w900,
                                            color: isSelectedToday
                                                ? Colors.deepPurple
                                                : isSelected
                                                    ? Colors.white
                                                    : null,
                                          ),
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4)),
                                        Text(
                                          dayName.toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: isSelectedToday
                                                ? FontWeight.w900
                                                : FontWeight.normal,
                                            color: isSelectedToday
                                                ? Colors.deepPurple
                                                : isSelected
                                                    ? Colors.white
                                                    : null,
                                          ),
                                        ),
                                      ]),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                content: Column(
                  children: [
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    FutureBuilder(
                      future: all_tasks,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var todos = snapshot.data;
                          print(todos);

                          Map<String, List<Task>> tasksByHour = {};
                          // group the tasks by hour
                          for (int i = 0; i < todos!.length; i++) {
                            print(todos[i].date);
                            DateTime format =
                                DateFormat('dd/MM/yyyy').parse(todos[i].date);
                            print(format);
                            // DateTime date = DateTime.parse(todos[i].date);
                            // print(date);
                            DateTime taskDate =
                                DateFormat("MM/dd/yyyy").parse(todos[i].date);
                            if (DateFormat('MM/dd/yyyy').format(taskDate) !=
                                DateFormat('MM/dd/yyyy')
                                    .format(_selectedDate)) {
                              continue;
                            }
                            String hour = DateFormat('hh a').format(
                                DateFormat("hh:mm a")
                                    .parse(todos[i].start_time));

                            if (!tasksByHour.containsKey(hour)) {
                              tasksByHour[hour] = [];
                            }
                            tasksByHour[hour]!.add(todos[i]);
                          }
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.fromLTRB(18, 18, 15, 0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
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
                                  // return tasks.isNotEmpty ?
                                  return Column(children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
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
                                                  style: const TextStyle(
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
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 0, 10, 5),
                                                  child: Card(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(0, 0, 0, 10),
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
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      subtitle: Text(
                                                        task.start_time,
                                                        style: const TextStyle(
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
                                    const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10)),
                                  ]);
                                  // : SizedBox.shrink();
                                },
                              ));
                        } else {
                          return const Center(
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

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
