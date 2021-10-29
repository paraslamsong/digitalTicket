import 'dart:math';

import 'package:fahrenheit/constraints/constants.dart';
import 'package:fahrenheit/screens/EventDetail/EventDetailsPage.dart';
import 'package:fahrenheit/screens/EventToday/Models/Events.dart';
import 'package:fahrenheit/widgets/IconGradient.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class EventToday extends StatefulWidget {
  @override
  _EventTodayState createState() => _EventTodayState();
}

class _EventTodayState extends State<EventToday> {
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
        Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: Text(
            "TODAY",
            style: TextStyle(
              fontSize: 45.0,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 20.0),
        FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data.events;
              return Container(
                height: 202,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(0.0),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) =>
                      _eventSlideShow(data[index]),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return _loading();
            } else
              return Text(snapshot.error.toString());
          },
        ),
      ],
    );
  }

  Widget _loading() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey.withOpacity(0.6),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _eventSlideShow(Event event) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              child: Image.network(
                event.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                color: Colors.black45,
                colorBlendMode: BlendMode.overlay,
              ),
            ),
            _calendarBox(DateTime.parse(event.startDate)),
            Positioned(
              bottom: 18,
              left: 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.eventTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    DateFormat("EEEE, hh:mma")
                        .format(DateTime.parse(event.startDate.toString())),
                    style: TextStyle(color: Colors.white, fontSize: 10.0),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    children: [
                      RadiantGradientMask(
                        child: Icon(
                          Icons.location_on,
                          size: 9.0,
                        ),
                      ),
                      Text(
                        "$CLUB_NAME, ${event.location}",
                        style:
                            TextStyle(color: Color(0xff46C2FF), fontSize: 8.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventDetailsPage(id: event.id)),
          );
        },
      ),
    );
  }

  Widget _calendarBox(DateTime date) {
    return Positioned(
      top: 20,
      left: -13,
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: LinearGradient(
            colors: [
              Color(0xff6469D5),
              Color(0xffBF6469),
            ],
            stops: [0.0, 1.0],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
          ),
        ),
        child: Text(
          "${DateFormat("MMM").format(date).toUpperCase()}\n${date.day}",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
