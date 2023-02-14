import "package:flutter/material.dart";

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 40),
            Center(
                child: Column(children: [
              CircleAvatar(
                  backgroundImage: AssetImage("profile/gabin.jpeg"),
                  radius: 100.0),
              SizedBox(height: 15),
              Text("Gabin",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              Container(
                  padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                  margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
                  child: Column(children: [
                Row(
                  children: [
                    Image.asset("profile/Badge.png", scale: 2,),
                    Text("Gabin ISHIMWE")
                  ],
                )
              ]))
            ])),
          ],
        ),
      ),
    );
  }
}
