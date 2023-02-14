import "package:flutter/material.dart";

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
            title: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Image.asset('profile/logo.png'),
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                )),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 40),
                Center(
                    child: Column(children: [
                  CircleAvatar(
                      backgroundImage: AssetImage("assets/profile/gabin.jpeg"),
                      radius: 100.0),
                  SizedBox(height: 25),
                  Text("Gabin",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
                      margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
                      child: Column(children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/profile/Badge.png",
                              width: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Gabin ISHIMWE",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Image.asset(
                              "assets/profile/mail.png",
                              width: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("g.ishimwe@lustudent.com",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Image.asset(
                              "assets/profile/joined.png",
                              width: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Joined February 12, 2023",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ])),
                ])),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 120),
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
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
            )));
  }
}
