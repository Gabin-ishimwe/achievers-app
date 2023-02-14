import 'package:achievers_app/screens/onboarding_screen.dart';
import 'package:achievers_app/screens/sign_in_screen.dart';
import 'package:achievers_app/screens/sign_up_screen.dart';
import 'package:achievers_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:select_form_field/select_form_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Achievers App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      home: CreateTaskPage(),
    );
  }
}

// CreateTaskPage is a stateful widget that holds a page where the user can create a task
class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPage();
}

// _CreateTaskPage is the state object for the CreateTaskPage widget.
class _CreateTaskPage extends State<CreateTaskPage> {
  // instance of the Status enum

  //a variable that will hold the priority that the user gives a task
  var sessions = 0.0;
  var short_break = 0.0;
  var long_break = 0.0;

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'school',
      'label': 'School',
    },
    {
      'value': 'health',
      'label': 'Health',
    },
    {
      'value': 'leisure',
      'label': 'Leisure',
    },
  ];

  // overrides the build function of a state object
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          // adds margin to create space between the screen edges and the content
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //adds space at the top
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              // add the title on the page
              Text(
                "Create New Task",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              // adds space between the title and the following text field
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
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
              // Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              // Row(children: [
              //   Column(children: [
              //     Text(
              //       "Date",
              //       style: TextStyle(
              //           fontSize: 14,
              //           color: Colors.black.withOpacity(.85),
              //           fontWeight: FontWeight.w600),
              //     ),
              //     Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              //   ]),
              //   Column(children: [
              //     Text(
              //       "Start time",
              //       style: TextStyle(
              //           fontSize: 14,
              //           color: Colors.black.withOpacity(.85),
              //           fontWeight: FontWeight.w600),
              //     ),
              //     Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              //   ]),
              // ]),

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
                  hintText: 'Category',
                  items: _items,
                  onChanged: (val) => print(val),
                  onSaved: (val) => print(val),
                  decoration: InputDecoration(
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
                      thumbColor: Colors.blue,
                      activeTrackColor: Colors.lightBlue[300],
                      inactiveTrackColor: Colors.grey[300],
                      valueIndicatorColor: Colors.blue,
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
                      thumbColor: Colors.blue,
                      activeTrackColor: Colors.lightBlue[300],
                      inactiveTrackColor: Colors.grey[300],
                      valueIndicatorColor: Colors.blue,
                      showValueIndicator: ShowValueIndicator.always,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                      valueIndicatorTextStyle:
                          TextStyle(fontSize: 12, color: Colors.white),
                      trackHeight: 5,
                    ),
                    child: Slider(
                      value: short_break,
                      onChanged: ((value) {
                        setState(() {
                          short_break = value;
                        });
                      }),
                      min: 0,
                      max: 10,
                      divisions: 10,
                      label: "$short_break",
                    ),
                  )
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
                      thumbColor: Colors.blue,
                      activeTrackColor: Colors.lightBlue[300],
                      inactiveTrackColor: Colors.grey[300],
                      valueIndicatorColor: Colors.blue,
                      showValueIndicator: ShowValueIndicator.always,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                      valueIndicatorTextStyle:
                          TextStyle(fontSize: 12, color: Colors.white),
                      trackHeight: 5,
                    ),
                    child: Slider(
                      value: long_break,
                      onChanged: ((value) {
                        setState(() {
                          long_break = value;
                        });
                      }),
                      min: 0,
                      max: 15,
                      divisions: 15,
                      label: "$long_break",
                    ),
                  )
                ],
              ),
              // adds space before the button
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              // a button that is elevated i.e. has a shadow
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text("Create new task"),
              )
            ],
          )),
    );
  }
}
