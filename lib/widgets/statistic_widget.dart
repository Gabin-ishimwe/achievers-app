import 'package:achievers_app/models/task_model.dart';
import 'package:achievers_app/repositories/task_repository.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsWidget extends StatefulWidget {
  const StatisticsWidget({super.key});

  @override
  State<StatisticsWidget> createState() => _StatisticsWidgetState();
}

class _StatisticsWidgetState extends State<StatisticsWidget> {
  // late var allTasks;
  late List<Task> newTasks;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // allTasks = [
    //   Task(week: "Mon", completedTask: 5),
    //   Task(week: "Tue", completedTask: 2),
    //   Task(week: "Wed", completedTask: 3),
    //   Task(week: "Thur", completedTask: 1),
    //   Task(week: "Fri", completedTask: 4),
    //   Task(week: "Sat", completedTask: 8),
    //   Task(week: "Sun", completedTask: 8),
    // ];
    // newTasks =Db.allTasks();
    // for (Task task in newTasks) {
    //   DateTime dateTime =
    //       DateTime.parse('20' + task.date.split('/').reversed.join());
    //   String weekday = DateFormat('EEEE').format(dateTime);
    //   print(weekday);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Image.asset(
                    "assets/logo/logo.png",
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 10)),
                const Text(
                  "Statistics",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
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
            FutureBuilder(
                future: Db.getWeekdayCounts(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    dynamic allTasks = snapshot.data;
                    return Container(
                      child: SfCartesianChart(
                        series: <ChartSeries>[
                          ColumnSeries(
                            dataSource: allTasks,
                            xValueMapper: (dynamic task, _) => task.name,
                            yValueMapper: (dynamic task, _) => task.completed,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                            color: Colors.deepPurple,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                          ),
                        ],
                        primaryXAxis: CategoryAxis(),
                        primaryYAxis: NumericAxis(),
                      ),
                    );
                  } else {
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                })),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Insights",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 250,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF04060F).withOpacity(0.05),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.asset("assets/images/fire.png"),
                          ),
                          const Text(
                            "Current Streaks",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          const Text(
                            "7",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          const Text(
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
                const Padding(padding: EdgeInsets.only(right: 20)),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 250,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF04060F).withOpacity(0.05),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              Icons.timer,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                          const Text(
                            "Daily Average",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          const Text(
                            "5",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          const Text(
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

// class Task {
//   final String week;
//   final int completedTask;
//   Task({required this.week, required this.completedTask});
// }
