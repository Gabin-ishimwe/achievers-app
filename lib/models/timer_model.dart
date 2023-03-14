class TimerModel {
  String time;
  int seconds;
  String midText;
  String lowerText;
  var primaryColor;
  var secondColor;

  TimerModel({required this.time, required this.seconds, required this.midText, required this.lowerText, required this.primaryColor, required this.secondColor});
}

List<TimerModel> timerContents = [
  TimerModel(
      time: "25:00",
      seconds: 1500,
      midText: "1/4 sessions",
      lowerText: "Stay focused for 25 minutes",
      primaryColor: 0xFF00a9f1,
      secondColor: 0xFFd9f2fd
  ),
  TimerModel(
      time: "5:00",
      seconds: 300,
      midText: "Short break",
      lowerText: "Take a short break for 5 minutes",
      primaryColor: 0xFFffd300,
      secondColor: 0xFFfff8d9
  ),
  TimerModel(
      time: "25:00",
      seconds: 1500,
      midText: "2/4 sessions",
      lowerText: "Stay focused for 25 minutes",
      primaryColor: 0xFF00a9f1,
      secondColor: 0xFFd9f2fd
  ),
  TimerModel(
      time: "15:00",
      seconds: 900,
      midText: "Long break",
      lowerText: "Take break for 15 minutes",
      primaryColor: 0xFF21c064,
      secondColor: 0xFFdef6e8
  ),
  TimerModel(
      time: "25:00",
      seconds: 1500,
      midText: "3/4 sessions",
      lowerText: "Stay focused for 25 minutes",
      primaryColor: 0xFF00a9f1,
      secondColor: 0xFFd9f2fd
  ),
  
  TimerModel(
      time: "5:00",
      seconds: 300,
      midText: "Short break",
      lowerText: "Take a short break for 5 minutes",
      primaryColor: 0xFFffd300,
      secondColor: 0xFFfff8d9
  ),
  TimerModel(
      time: "25:00",
      seconds: 1500,
      midText: "4/4 sessions",
      lowerText: "Stay focused for 25 minutes",
      primaryColor: 0xFF00a9f1,
      secondColor: 0xFFd9f2fd
  ),
];
