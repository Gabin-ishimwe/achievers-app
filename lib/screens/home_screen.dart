import 'package:achievers_app/repositories/auth_repository.dart';
import 'package:achievers_app/widgets/create_task_widget.dart';
import 'package:achievers_app/widgets/home_widget.dart';
import 'package:achievers_app/widgets/profile_widget.dart';
import 'package:achievers_app/widgets/statistic_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List homeWidgets = [
    HomeScreenWidget(),
    Center(
      child: Text("All task page (To be implemented)"),
    ),
    CreateTaskWidget(),
    StatisticsWidget(),
    ProfileWidget(),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: homeWidgets[currentIndex],
      bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.white,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Color(0xFF5F06EE),
            textTheme: Theme.of(context).textTheme.copyWith(
                  caption: new TextStyle(color: Color(0xFF7C7575)),
                ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: 0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                  icon: CircleAvatar(child: Icon(Icons.add)), label: ''),
              BottomNavigationBarItem(
                icon: Icon(Icons.insert_chart),
                label: 'Statistics',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          )),
    ));
  }
}
