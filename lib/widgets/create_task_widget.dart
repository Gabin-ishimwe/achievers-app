import "package:achievers_app/helpers/notification.dart";
import "package:achievers_app/models/task_model.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:select_form_field/select_form_field.dart";
import 'package:intl/intl.dart';

import "../screens/session_timer.dart";

import "../screens/session_timer.dart";

class CreateTaskWidget extends StatefulWidget {
  const CreateTaskWidget({super.key});

  @override
  State<CreateTaskWidget> createState() => _CreateTaskWidgetState();
}

class _CreateTaskWidgetState extends State<CreateTaskWidget> {
  //a variable that will hold the priority that the user gives a task
  var sessions = 0.0;
  var short_break = 0.0;
  var long_break = 0.0;

  var title_controller = TextEditingController();
  var description_controller = TextEditingController();
  var date_controller = TextEditingController();
  var start_time_controller = TextEditingController();
  var category_controller = TextEditingController();
  var working_session_duration_controller = TextEditingController(text: '25');
  var working_sessions_controller = TextEditingController();
  var short_break_controller = TextEditingController(text: '5');
  var long_break_controller = TextEditingController(text: '15');
  var long_break_starts_controller = TextEditingController();

  TextEditingController? dateController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TextEditingController? timeController = TextEditingController();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();


  final List<Map<String, dynamic>> _items = [
    {'value': 'code', 'label': 'Code'},
    {'value': 'health', 'label': 'Health'},
    {'value': 'leisure', 'label': 'Leisure'},
    {'value': 'school', 'label': 'School'},
    {'value': 'entertainment', 'label': 'Entertainment'},
  ];

  final _longBreakOptions = ['0'];
  List<Map<String, dynamic>>? dropdownItems = [];
  List options = [];
  final _selectedLongBreakStarts = 0;

  @override
  void initState() {
    super.initState();

    NotificationClass.init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() {
    NotificationClass.onNotifications.stream.listen(onClickedNotification);
  }

  void onClickedNotification(String? payload) {
    print('clicked on notification $payload');
    Get.to(const TimerScreen(), arguments: {'taskId': payload});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Container(
          // adds margin to create space between the screen edges and the content
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      splashColor: Colors.transparent,
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 20,
                  ),
                  // add the title on the page
                  const Text(
                    "Create New Task",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              // adds space between the title and the following text field
              const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              // a text field that receives user input for the title of the task
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(.85),
                        fontWeight: FontWeight.w600),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  TextFormField(
                    controller: title_controller,
                    decoration: InputDecoration(
                      // labelText: 'Name',
                      hintText: 'Task title',
                      hintStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color(0x004c05be).withOpacity(1)),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      hoverColor: Colors.grey.withOpacity(0),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(.85),
                        fontWeight: FontWeight.w600),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  TextFormField(
                    controller: description_controller,
                    decoration: InputDecoration(
                      // labelText: 'Name',
                      hintText: 'Short description',
                      hintStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color(0x004c05be).withOpacity(1)),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      hoverColor: Colors.grey.withOpacity(0),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),

              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Date",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(.85),
                      fontWeight: FontWeight.w600),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                TextFormField(
                  controller: dateController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_month),
                        onPressed: () {
                          _getDateFromUser();
                        },
                      ),
                      suffixIconColor: Color(0xFFC1C1C1),
                      fillColor: Color(0xFFC1C1C1).withOpacity(0.2),
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: DateFormat.yMd().format(_selectedDate),
                      hintStyle: TextStyle(
                        color: Color(0xFFC1C1C1),
                      )),
                ),
                // adds a space after before the following column
              ]),

              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),

              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Start time",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(.85),
                      fontWeight: FontWeight.w600),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                TextFormField(
                  controller: timeController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.access_time),
                        onPressed: () {
                          _getTimeFromUser();
                        },
                      ),
                      suffixIconColor: Color(0xFFC1C1C1),
                      fillColor: Color(0xFFC1C1C1).withOpacity(0.2),
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: _startTime,
                      hintStyle: TextStyle(
                        color: Color(0xFFC1C1C1),
                      )),
                ),
                // adds a space after before the following column
              ]),

              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Select Category",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(.85),
                      fontWeight: FontWeight.w600),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                SelectFormField(
                  type: SelectFormFieldType.dropdown,
                  items: _items,
                  enableSearch: true,
                  controller: category_controller,
                  decoration: InputDecoration(
                    hintText: 'Category',
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color(0x004c05be).withOpacity(1)),
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.1),
                  ),
                )
                // adds a space after before the following column
              ]),

              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How many minutes should your work session be?",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(.85),
                        fontWeight: FontWeight.w600),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  TextFormField(
                    controller: working_session_duration_controller,
                    decoration: InputDecoration(
                      // labelText: 'Name',
                      hintText: '25',
                      hintStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color(0x004c05be).withOpacity(1)),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      hoverColor: Colors.grey.withOpacity(0),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),

              // a column that holds the task priority slider
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // a label for the slider
                  Text(
                    "Working Sessions",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(.85),
                        fontWeight: FontWeight.w600),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  // a slider that will be used to specify the task priority
                  SliderTheme(
                    data: SliderThemeData(
                      thumbColor: Colors.deepPurple,
                      activeTrackColor: Colors.deepPurple,
                      inactiveTrackColor: Colors.grey[300],
                      valueIndicatorColor: Colors.deepPurple,
                      showValueIndicator: ShowValueIndicator.always,
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 10),
                      valueIndicatorTextStyle:
                          const TextStyle(fontSize: 12, color: Colors.white),
                      trackHeight: 5,
                    ),
                    child: Slider(
                      value: sessions,
                      onChanged: ((value) {
                        setState(() {
                          sessions = value;
                          options =
                              List.generate(value.toInt(), (index) => index);

                          // options = options.map((i) => i.toString()).toList();
                          dropdownItems = options
                              .map((number) => (({
                                    "value": number,
                                    "label":
                                        number == 0 ? 'No long break' : number
                                  })))
                              .toList();
                        });
                      }),
                      min: 0,
                      max: 8,
                      divisions: 8,
                      label: "$sessions",
                    ),
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How many minutes should your short break be?",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(.85),
                        fontWeight: FontWeight.w600),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  TextFormField(
                    controller: short_break_controller,
                    decoration: InputDecoration(
                      // labelText: 'Name',
                      hintText: '5',
                      hintStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color(0x004c05be).withOpacity(1)),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      hoverColor: Colors.grey.withOpacity(0),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How many minutes should your long break be?",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(.85),
                        fontWeight: FontWeight.w600),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  TextFormField(
                    controller: long_break_controller,
                    decoration: InputDecoration(
                      // labelText: 'Name',
                      hintText: '15',
                      hintStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: const Color(0x004c05be).withOpacity(1)),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      hoverColor: Colors.grey.withOpacity(0),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "After how many sessions should your long break begin",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(.85),
                      fontWeight: FontWeight.w600),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                SelectFormField(
                  type: SelectFormFieldType.dropdown,
                  items: dropdownItems,
                  // value:_selectedLongBreakStarts,
                  controller: long_break_starts_controller,
                  enableSearch: true,
                  onChanged: (val) => print(val),
                  onSaved: (val) => print(val),
                  decoration: InputDecoration(
                    hintText: 'Select number of sessions',
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color(0x004c05be).withOpacity(1)),
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.1),
                  ),
                )
                // adds a space after before the following column
              ]),

              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              // a button that is elevated i.e. has a shadow
              ElevatedButton(
                onPressed: () {
                  String? selectedValue = long_break_starts_controller.text;
                  int longBreak = -1;
                  print("SelectedValue $selectedValue");
                  if (selectedValue != null) {
                    longBreak = int.parse(selectedValue);
                  }
                  if (title_controller.text != null &&
                      description_controller.text != null &&
                      date_controller.text != null &&
                      start_time_controller.text != null &&
                      category_controller.text != null &&
                      sessions != null &&
                      working_session_duration_controller.text != null &&
                      short_break_controller.text != null &&
                      long_break_controller.text != null &&
                      longBreak != -1) {
                    var newTask = Task(
                        title: title_controller.text,
                        description: description_controller.text,
                        date: formatDateW(_selectedDate),
                        start_time: _startTime,
                        category: category_controller.text,
                        working_sessions: sessions.toInt(),
                        working_session_duration:
                            int.parse(working_session_duration_controller.text),
                        short_break: int.parse(short_break_controller.text),
                        long_break: int.parse(long_break_controller.text),
                        long_break_starts: longBreak,
                        completed_sessions: 0,
                        completed: false);

                    createTask(newTask);
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                child: const Text(
                  "Create new task",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )),
    )));
  }

  Future createTask(task) async {
    final docTask = await FirebaseFirestore.instance
        .collection("tasks")
        .add(task.toJson())
        .whenComplete(() => print("task created"))
        .catchError((err) => {throw err});

    var formattedT = formatTime(task.start_time);
    var time = DateFormat.jm()
        .format(DateTime.parse('${task.date} ${formattedT}'));
    NotificationClass.showScheduledNotification(
      title: 'Achievers app task reminder',
      body: '$time: It\'s time to start "${task.title}"',
      payload_data: docTask.id,
      scheduledDate: DateTime.parse('${task.date} ${formattedT}'),
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2121));

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
        print(_selectedDate);
      });
    } else {
      print("it's null date");
    }
  }

  _getTimeFromUser() async {
    var _pickedTime = await _showTimePicker();
    String _formatedTime = _pickedTime.format(context);
    if (_pickedTime == null) {
      print("it's null time");
    } else {
      setState(() {
        _startTime = _formatedTime;
        print(_startTime);
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
  }

  String formatTime(String timeString) {
    DateTime parsedTime = DateFormat.jm().parse(
        timeString); // Parse the time string using Flutter's DateFormat class
    String formattedTime = DateFormat.Hm().format(
        parsedTime); // Format the parsed time string in 24-hour format

    return formattedTime;
  }

  String formatDateW(DateTime datesel) {

  // Create a formatter that will format the DateTime object to the desired output format
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  // Format the DateTime object to a string in the desired output format
  String formattedDate = formatter.format(datesel);

  // Return the formatted string
  return formattedDate;
}
}
