import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Center(
        child: CreateTaskPage(),
      ),
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
  var priority = 0.0;

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
              Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              // add the title on the page
              Text(
                "Create New Task",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // adds space between the title and the following text field
              Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              // a text field that receives user input for the title of the task
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Task status",
                    style: TextStyle(fontSize: 16),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  TextFormField(
                    decoration: InputDecoration(
                      // labelText: 'Name',
                      hintText: 'Task title',
                      hintStyle: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                      ),
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
              // adds space between the text fields
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              // a text field that receives user input for the description of the task
              TextFormField(
                decoration: InputDecoration(
                  // labelText: 'Name',
                  hintText: 'Enter your name',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  filled: true,
                  fillColor: Colors.grey,
                  hoverColor: Colors.grey,
                ),
              ),
              // adds space after the text field
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),

              // a column that holds the task status options
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // a label for the task status options
                  Text(
                    "Task status",
                    style: TextStyle(fontSize: 16),
                  ),
                  // a row for a task status option

                  // a row for a task status option
                ],
              ),
              // adds a space after before the following column
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),

              // a column that holds the task priority slider
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // a label for the slider
                  Text(
                    "Task priority",
                    style: TextStyle(fontSize: 16),
                  ),

                  // a slider that will be used to specify the task priority
                  Slider(
                    value: priority,
                    onChanged: ((value) {
                      setState(() {
                        priority = value;
                      });
                    }),
                    min: 0,
                    max: 5,
                    divisions: 5,
                    label: "$priority",
                    thumbColor: Color(0xFF476EBE),
                    activeColor: Color(0xFF476EBE),
                  ),
                ],
              ),
              // adds space before the button
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              // a button that is elevated i.e. has a shadow
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Color(0xFF476EBE)),
                child: const Text("Add new task"),
              )
            ],
          )),
    );
  }
}
