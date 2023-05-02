import "package:achievers_app/models/task_model.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:select_form_field/select_form_field.dart";

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
  var long_break_starts_controller;

  final List<Map<String, dynamic>> _items = [
    {'value': 'code', 'label': 'Code'},
    {'value': 'health', 'label': 'Health'},
    {'value': 'leisure', 'label': 'Leisure'},
    {'value': 'school', 'label': 'School'},
    {'value': 'entertainment', 'label': 'Entertainment'},
  ];

  var _longBreakOptions = ['0'];
  List<Map<String, dynamic>>? dropdownItems = [];
  List options = [];
  var _selectedLongBreakStarts = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Container(
          // adds margin to create space between the screen edges and the content
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      splashColor: Colors.transparent,
                    ),
                  ),

                  SizedBox(
                    width: 20,
                  ),
                  // add the title on the page
                  Text(
                    "Create New Task",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              // adds space between the title and the following text field
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
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
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  TextFormField(
                    controller: title_controller,
                    decoration: InputDecoration(
                      // labelText: 'Name',
                      hintText: 'Task title',
                      hintStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0x4C05BE).withOpacity(1)),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      hoverColor: Colors.grey.withOpacity(0),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),

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
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  TextFormField(
                    controller: description_controller,
                    decoration: InputDecoration(
                      // labelText: 'Name',
                      hintText: 'Short description',
                      hintStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0x4C05BE).withOpacity(1)),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      hoverColor: Colors.grey.withOpacity(0),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),

              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Date",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(.85),
                      fontWeight: FontWeight.w600),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                TextFormField(
                  controller: date_controller,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.calendar_month),
                      suffixIconColor: Color(0xFFC1C1C1),
                      fillColor: Color(0xFFC1C1C1).withOpacity(0.2),
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: "Date",
                      hintStyle: TextStyle(
                        color: Color(0xFFC1C1C1),
                      )),
                ),
                // adds a space after before the following column
              ]),

              Padding(padding: EdgeInsets.symmetric(vertical: 10)),

              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Start time",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(.85),
                      fontWeight: FontWeight.w600),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                TextFormField(
                  controller: start_time_controller,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.access_time),
                      suffixIconColor: Color(0xFFC1C1C1),
                      fillColor: Color(0xFFC1C1C1).withOpacity(0.2),
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: "Start time",
                      hintStyle: TextStyle(
                        color: Color(0xFFC1C1C1),
                      )),
                ),
                // adds a space after before the following column
              ]),

              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Select Category",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(.85),
                      fontWeight: FontWeight.w600),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 5)),
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
                    contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0x4C05BE).withOpacity(1)),
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.1),
                  ),
                )
                // adds a space after before the following column
              ]),

              Padding(padding: EdgeInsets.symmetric(vertical: 10)),

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
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  TextFormField(
                    controller: working_session_duration_controller,
                    decoration: InputDecoration(
                      // labelText: 'Name',
                      hintText: '25',
                      hintStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0x4C05BE).withOpacity(1)),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      hoverColor: Colors.grey.withOpacity(0),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),

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
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  // a slider that will be used to specify the task priority
                  SliderTheme(
                    data: SliderThemeData(
                      thumbColor: Colors.deepPurple,
                      activeTrackColor: Colors.deepPurple,
                      inactiveTrackColor: Colors.grey[300],
                      valueIndicatorColor: Colors.deepPurple,
                      showValueIndicator: ShowValueIndicator.always,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                      valueIndicatorTextStyle:
                          TextStyle(fontSize: 12, color: Colors.white),
                      trackHeight: 5,
                    ),
                    child: Slider(
                      value: sessions,
                      onChanged: ((value) {
                        setState(() {
                          sessions = value;
                          options = List.generate(value.toInt(), (index) => index);;
                          // options = options.map((i) => i.toString()).toList();
                          dropdownItems = options
                              .map((number) =>
                                  (({"value": number, "label": number == 0 ? 'No long break' : number})))
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
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),

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
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  TextFormField(
                    controller: short_break_controller,
                    decoration: InputDecoration(
                      // labelText: 'Name',
                      hintText: '5',
                      hintStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0x4C05BE).withOpacity(1)),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      hoverColor: Colors.grey.withOpacity(0),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),

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
                  Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  TextFormField(
                    controller: long_break_controller,
                    decoration: InputDecoration(
                      // labelText: 'Name',
                      hintText: '15',
                      hintStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0x4C05BE).withOpacity(1)),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.1),
                      hoverColor: Colors.grey.withOpacity(0),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "After how many sessions should your long break begin",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(.85),
                      fontWeight: FontWeight.w600),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 5)),
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
                    contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0x4C05BE).withOpacity(1)),
                    ),
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.1),
                  ),
                )
                // adds a space after before the following column
              ]),

              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              // a button that is elevated i.e. has a shadow
              ElevatedButton(
                onPressed: () {
                  String? selectedValue = long_break_starts_controller?.text;
                  int long_break = -1;
                  if (selectedValue != null) {
                    long_break = int.parse(selectedValue);
                  } 
                  if (title_controller.text != null ||
                      description_controller.text != null ||
                      date_controller.text != null ||
                      start_time_controller.text != null ||
                      category_controller.text != null ||
                      sessions != null ||
                      working_session_duration_controller.text != null ||
                      short_break_controller.text != null ||
                      long_break_controller.text != null ||
                      long_break != -1) {
                    var new_task = Task(
                        title: title_controller.text,
                        description: description_controller.text,
                        date: date_controller.text,
                        start_time: start_time_controller.text,
                        category: category_controller.text,
                        working_sessions: sessions.toInt(),
                        working_session_duration:
                            int.parse(working_session_duration_controller.text),
                        short_break: int.parse(short_break_controller.text),
                        long_break: int.parse(long_break_controller.text),
                        long_break_starts: long_break,
                        completed_sessions: 0,
                        completed: false
                        );
                        
                    createTask(new_task);
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
        .collection("userTasks")
        .add(task.toJson())
        .whenComplete(() => print("task created"))
        .catchError((err) => {throw err});
  }
}
