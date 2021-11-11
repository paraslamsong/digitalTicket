import 'package:fahrenheit/screens/FoodOrderPage.dart';
import 'package:flutter/material.dart';

//Custom Package
import 'package:fahrenheit/screens/TableBooking/Widgets/FirstFloorPage.dart';
import 'package:toast/toast.dart';

class TableBookingPage extends StatefulWidget {
  @override
  _TableBookingPageState createState() => _TableBookingPageState();
}

class _TableBookingPageState extends State<TableBookingPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.5, 0.5],
            colors: [
              Color(0xff28282C),
              Colors.black,
            ],
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30.0),
              )),
              backgroundColor: Colors.black,
              title: Text('TABLE BOOKING'),
              bottom: PreferredSize(
                preferredSize: Size(double.infinity, 20),
                child: Container(),
              ),
            ),
            body: Column(
              children: [
                TabBar(
                  indicator: UnderlineTabIndicator(
                      borderSide:
                          BorderSide(color: Color(0xff5FCAF2), width: 2)),
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.label,
                  onTap: (index) {
                    // Tab index when user select it, it start from zero
                  },
                  tabs: [
                    Tab(
                      text: "First floor",
                    ),
                    Tab(
                      text: "Second floor",
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      FirstFloorPage(),
                      FirstFloorPage(),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 45.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FoodOrderPage()),
                      );
                    },
                    child: Text(
                      "Add Food",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  height: 45.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextButton(
                    onPressed: () {
                      Toast.show("Book Table", context,
                          gravity: Toast.BOTTOM,
                          duration: Toast.LENGTH_LONG,
                          backgroundColor: Colors.black);
                    },
                    child: Text(
                      "Book Table",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
