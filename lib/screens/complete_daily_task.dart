import 'package:flutter/material.dart';

class CompleteDailyTask extends StatefulWidget {
  const CompleteDailyTask({super.key});

  @override
  State<CompleteDailyTask> createState() => _CompleteDailyTaskState();
}

class _CompleteDailyTaskState extends State<CompleteDailyTask> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(20),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(
            children: [
              InkWell(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
                splashColor: Colors.transparent,
              ),
              Padding(padding: EdgeInsets.only(right: 10)),
              Text(
                "Celebration",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              )
            ],
          ),
          // SizedBox(
          //   height: 50,
          // ),
          Expanded(child: Image.asset("assets/images/trophie.png")),
          Align(
            child: Text(
              "Congratulations",
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 32,
                  fontWeight: FontWeight.w800),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "You just completed one of your tasks today. Click on Home to choose another one. Keep going!!! ",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Home",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
          ),
          SizedBox(
            height: 100,
          )
        ]),
      ),
    ));
    ;
  }
}
