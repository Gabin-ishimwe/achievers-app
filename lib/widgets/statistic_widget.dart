import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsWidget extends StatefulWidget {
  const StatisticsWidget({super.key});

  @override
  State<StatisticsWidget> createState() => _StatisticsWidgetState();
}

class _StatisticsWidgetState extends State<StatisticsWidget> {
  late List<Task> allTasks;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allTasks = [
      Task(week: "Mon", completedTask: 5),
      Task(week: "Tue", completedTask: 2),
      Task(week: "Wed", completedTask: 3),
      Task(week: "Thur", completedTask: 1),
      Task(week: "Fri", completedTask: 4),
      Task(week: "Sat", completedTask: 8),
      Task(week: "Sun", completedTask: 8),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Image.asset(
                    "assets/logo/logo.png",
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 10)),
                Text(
                  "Statistics",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your statistics graph",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "This week",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: SfCartesianChart(
                series: <ChartSeries>[
                  ColumnSeries(
                    dataSource: allTasks,
                    xValueMapper: (dynamic task, _) => task.week,
                    yValueMapper: (dynamic task, _) => task.completedTask,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                  ),
                ],
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Insights",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 250,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Color(0xFF04060F).withOpacity(0.05),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ]),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            padding: EdgeInsets.all(10),
                            child: Image.asset("assets/images/fire.png"),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          Text(
                            "Current Streaks",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          Text(
                            "7",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          Text(
                            "Days you used Achievers consistently",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ]),
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 20)),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 250,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Color(0xFF04060F).withOpacity(0.05),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ]),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.timer,
                              color: Colors.white,
                              size: 26,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          Text(
                            "Daily Average",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          Text(
                            "5",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          Text(
                            "Average number of tasks completed daily",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ]),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    ));
  }
}

class Task {
  final String week;
  final int completedTask;
  Task({required this.week, required this.completedTask});
}
