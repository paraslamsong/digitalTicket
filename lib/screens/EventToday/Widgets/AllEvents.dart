import 'package:fahrenheit/constraints/constants.dart';
import 'package:fahrenheit/screens/EventToday/Models/Events.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class AllEvents extends StatefulWidget {
  final Events events;
  AllEvents(this.events);
  @override
  _AllEventsState createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
  Future<Events> fetchData() async {
    Events events = new Events();
    await events.fetchTodaysEvent();
    return Future.value(events);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 33.0),
        Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: Text("ALL EVENTS",
              style: TextStyle(fontSize: 26.0, color: Colors.white)),
        ),
        SizedBox(height: 20.0),
        ListView.builder(
          physics: ScrollPhysics(),
          itemCount: widget.events.events.length,
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              _allEvents(widget.events.events[index]),
        ),
        // FutureBuilder(
        //   future: fetchData(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Container(
        //         height: 200,
        //         child: Center(
        //           child: Lottie.asset("assets/loading.json"),
        //         ),
        //       );
        //     } else if (snapshot.hasData) {
        //       var data = snapshot.data.events;
        //       print(data.length);
        //       return
        //     } else
        //       return Text(snapshot.error.toString());
        //   },
        // ),
      ],
    );
  }

  Widget _allEvents(Event event) {
    return Container(
      height: 100.0,
      color: Colors.black,
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Row(
        children: <Widget>[
          //All Events Image
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            child: Container(
              child: Image.network(event.image,
                  width: 165, height: 100, fit: BoxFit.fill),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 6),
                //All Events Title
                Text(
                  event.eventTitle,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold),
                ),
                //All Events Description
                SizedBox(height: 6),
                Expanded(
                  child: Text(
                    event.description,
                    style: TextStyle(fontSize: 7.0, color: Colors.white),
                  ),
                ),
                SizedBox(height: 6),
                //All Events Time
                Text(
                  DateFormat("EEEE, hh:mmaa")
                      .format(DateTime.parse(event.startDate.toString())),
                  style: TextStyle(color: Colors.white, fontSize: 9.0),
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: const Color(0xffb74093),
                      size: 8.0,
                    ),
                    SizedBox(width: 3),
                    //All Events Location
                    Text(
                      "$CLUB_NAME, ${event.location}",
                      style: TextStyle(
                          color: const Color(0xff46C2FF), fontSize: 6.0),
                    ),
                  ],
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
