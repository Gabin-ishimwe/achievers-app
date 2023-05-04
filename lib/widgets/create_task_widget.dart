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

  final title_controller = TextEditingController();
  final description_controller = TextEditingController();
  final date_controller = TextEditingController();
  final start_time_controller = TextEditingController();
  final category_controller = TextEditingController();
  final working_sessions_controller = TextEditingController();
  final short_break_controller = TextEditingController();
  final long_break_controller = TextEditingController();

  final List<Map<String, dynamic>> _items = [
    {'value': 'code', 'label': 'Code'},
    {'value': 'health', 'label': 'Health'},
    {'value': 'leisure', 'label': 'Leisure'},
    {'value': 'school', 'label': 'School'},
    {'value': 'entertainment', 'label': 'Entertainment'},
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  controller: date_controller,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.calendar_month),
                      suffixIconColor: const Color(0xFFC1C1C1),
                      fillColor: const Color(0xFFC1C1C1).withOpacity(0.2),
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: "Date",
                      hintStyle: const TextStyle(
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
                  controller: start_time_controller,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.access_time),
                      suffixIconColor: const Color(0xFFC1C1C1),
                      fillColor: const Color(0xFFC1C1C1).withOpacity(0.2),
                      filled: true,
                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      hintText: "Start time",
                      hintStyle: const TextStyle(
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
                  onChanged: (val) => print(val),
                  onSaved: (val) => print(val),
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
                  // Padding(padding: EdgeInsets.symmetric(vertical: 5)),
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
                          working_sessions_controller.text = value.toString();
                        });
                      }),
                      min: 0,
                      max: 8,
                      divisions: 4,
                      label: "$sessions",
                    ),
                  )
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
                    "Short Break",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(.85),
                        fontWeight: FontWeight.w600),
                  ),
                  // Padding(padding: EdgeInsets.symmetric(vertical: 5)),
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
                      value: short_break,
                      onChanged: ((value) {
                        setState(() {
                          short_break = value;
                          short_break_controller.text = value.toString();
                        });
                      }),
                      min: 0,
                      max: 10,
                      divisions: 2,
                      label: "$short_break",
                    ),
                  )
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
                    "Long Break",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(.85),
                        fontWeight: FontWeight.w600),
                  ),
                  // Padding(padding: EdgeInsets.symmetric(vertical: 5)),
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
                      value: long_break,
                      onChanged: ((value) {
                        setState(() {
                          long_break = value;
                          long_break_controller.text = value.toString();
                        });
                      }),
                      min: 0,
                      max: 15,
                      divisions: 3,
                      label: "$long_break",
                    ),
                  )
                ],
              ),
              // adds space before the button
              const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              // a button that is elevated i.e. has a shadow
              ElevatedButton(
                onPressed: () {
                  var newTask = Task(
                      title: title_controller.text,
                      description: description_controller.text,
                      date: date_controller.text,
                      start_time: start_time_controller.text,
                      category: category_controller.text,
                      working_sessions:
                          int.parse(working_sessions_controller.text),
                      short_break: int.parse(short_break_controller.text),
                      long_break: int.parse(long_break_controller.text),
                      long_break_starts: 0,
                      completed: false,
                      completed_sessions: 0);

                  createTask(newTask);
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
    );
  }

  Future createTask(task) async {
    final docTask = await FirebaseFirestore.instance
        .collection("tasks")
        .add(task.toJson())
        .whenComplete(() => print("task created"))
        .catchError((err) => {print(err)});
  }
}
