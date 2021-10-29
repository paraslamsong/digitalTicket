import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

// Custom Package
import 'package:fahrenheit/screens/FoodOrderPage.dart';

class FirstFloorPage extends StatefulWidget {
  @override
  _FirstFloorPageState createState() => _FirstFloorPageState();
}

class _FirstFloorPageState extends State<FirstFloorPage> {
  Color _available = Color(0xff6B6868),
      _occupied = Color(0xffF55A5A),
      _selected = Color(0xff5FCAF2);
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        _tableScheme(),
        _selectedTable(),
        _tableSelectionBox(),
        Container(
          height: 100.0,
          width: double.infinity,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget _tableScheme() {
    return Container(
      height: 150.0,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 35.0),
          Center(
            child: Text(
              "Please choose table of your choice",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Table on the Scheme",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 15.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _scheme(color: _available, title: "Available"),
                _scheme(color: _occupied, title: "Occupied"),
                _scheme(color: _selected, title: "Selected"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _scheme({Color color, String title}) {
    return InkWell(
      child: Row(
        children: [
          Container(
            height: 13.0,
            width: 18.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2), color: color),
          ),
          SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 10),
          )
        ],
      ),
      onTap: () {
        Toast.show(title, context,
            gravity: Toast.BOTTOM,
            duration: Toast.LENGTH_LONG,
            backgroundColor: Colors.black);
      },
    );
  }

  Widget _selectedTable() {
    Widget tableInfo(String title) {
      return Text(title, style: TextStyle(color: Colors.white, fontSize: 18.0));
    }

    return Column(
      children: [
        Container(
          height: 50.0,
          width: double.infinity,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Selected Table",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          color: Color(0xff28282C),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tableInfo("Floor : 2"),
              tableInfo("Table : 2"),
              tableInfo("Price : रू 5000"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tableSelectionBox() {
    return Container(
        height: 360.0,
        width: double.infinity,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 35.0),
          child: Container(
            height: 360.0,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text(
                    "Stage",
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, top: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Container(
                                    height: 12.0,
                                    width: 25.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: 6.0),
                                Container(
                                  height: 12.0,
                                  width: 25.0,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 10.0),
                                Container(
                                  height: 12.0,
                                  width: 25.0,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                            SizedBox(height: 6.0),
                            Row(
                              children: [
                                Container(
                                  height: 30.0,
                                  width: 12.0,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 6.0),
                                Container(
                                  height: 50.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6.0),
                                Container(
                                  height: 30.0,
                                  width: 12.0,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            SizedBox(height: 6.0),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Container(
                                    height: 12.0,
                                    width: 25.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: 6.0),
                                Container(
                                  height: 12.0,
                                  width: 25.0,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 10.0),
                                Container(
                                  height: 12.0,
                                  width: 25.0,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ],
                        ),
                        onTap: () {
                          Toast.show("Table1", context,
                              gravity: Toast.BOTTOM,
                              duration: Toast.LENGTH_LONG,
                              backgroundColor: Colors.black);
                        },
                      ),
                      InkWell(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Container(
                                    height: 12.0,
                                    width: 25.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: 6.0),
                                Container(
                                  height: 12.0,
                                  width: 25.0,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 10.0),
                                Container(
                                  height: 12.0,
                                  width: 25.0,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                            SizedBox(height: 6.0),
                            Row(
                              children: [
                                Container(
                                  height: 30.0,
                                  width: 12.0,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 6.0),
                                Container(
                                  height: 50.0,
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                    color: Colors.pink.withOpacity(0.7),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6.0),
                                Container(
                                  height: 30.0,
                                  width: 12.0,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            SizedBox(height: 6.0),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Container(
                                    height: 12.0,
                                    width: 25.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: 6.0),
                                Container(
                                  height: 12.0,
                                  width: 25.0,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 10.0),
                                Container(
                                  height: 12.0,
                                  width: 25.0,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ],
                        ),
                        onTap: () {
                          Toast.show("Table2", context,
                              gravity: Toast.BOTTOM,
                              duration: Toast.LENGTH_LONG,
                              backgroundColor: Colors.black);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 1.0,
                    width: 170.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 10.0,
                                  width: 15.0,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 20.0,
                                      width: 10.0,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 5.0),
                                    Container(
                                      height: 20.0,
                                      width: 10.0,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 5.0),
                                    Container(
                                      height: 20.0,
                                      width: 10.0,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                SizedBox(width: 5.0),
                                Container(
                                  height: 80.0,
                                  width: 35.0,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                Column(
                                  children: [
                                    Container(
                                      height: 20.0,
                                      width: 10.0,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 5.0),
                                    Container(
                                      height: 20.0,
                                      width: 10.0,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 5.0),
                                    Container(
                                      height: 20.0,
                                      width: 10.0,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              children: [
                                Container(
                                  height: 10.0,
                                  width: 15.0,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Toast.show("Table3", context,
                            gravity: Toast.BOTTOM,
                            duration: Toast.LENGTH_LONG,
                            backgroundColor: Colors.black);
                      },
                    ),
                    _table(),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget _table() {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.only(right: 40.0, bottom: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 10.0,
                  width: 15.0,
                  color: Colors.grey,
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: 20.0,
                      width: 10.0,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      height: 20.0,
                      width: 10.0,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      height: 20.0,
                      width: 10.0,
                      color: Colors.grey,
                    ),
                  ],
                ),
                SizedBox(width: 5.0),
                Container(
                  height: 80.0,
                  width: 35.0,
                  decoration: BoxDecoration(
                    color: Colors.pink.withOpacity(0.7),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(width: 5.0),
                Column(
                  children: [
                    Container(
                      height: 20.0,
                      width: 10.0,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      height: 20.0,
                      width: 10.0,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      height: 20.0,
                      width: 10.0,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Container(
                  height: 10.0,
                  width: 15.0,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        Toast.show("Table4", context,
            gravity: Toast.BOTTOM,
            duration: Toast.LENGTH_LONG,
            backgroundColor: Colors.black);
      },
    );
  }
}
