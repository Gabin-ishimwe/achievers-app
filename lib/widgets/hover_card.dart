import 'package:achievers_app/models/todo_model.dart';
import 'package:flutter/material.dart';

class HoverCard extends StatefulWidget {
  final TodoTask task;

  const HoverCard({required this.task});

  @override
  _HoverCardState createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: isHovering ? 300.0 : 200.0,
        width: isHovering ? 300.0 : 200.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
            child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF04060F).withOpacity(0.05),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Card(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                        autofocus: false,
                        leading: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(widget.task.color),
                          ),
                          child: Center(
                            child: Icon(
                              widget.task.icon,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                        title: Text(
                          widget.task.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        subtitle: Text(
                          widget.task.time,
                          style:
                              TextStyle(fontSize: 11, color: Color(0xFF7C7575)),
                        ),
                        trailing: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF39E180),
                                Color(0xFF1AB65C),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            // color:Color(0xFF1AB65C),
                          ),
                          child: Center(
                              child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          )),
                        )
                        // ),
                        )))),
      ),
    );
  }
}
