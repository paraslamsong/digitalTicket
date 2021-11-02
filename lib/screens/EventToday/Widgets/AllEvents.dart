import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahrenheit/constraints/constants.dart';
import 'package:fahrenheit/screens/EventDetail/EventDetailsPage.dart';
import 'package:fahrenheit/screens/EventToday/Models/Events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AllEvents extends StatelessWidget {
  final Events events;
  AllEvents(this.events);
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
          itemCount: this.events.events.length,
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              _allEvents(this.events.events[index], context),
        ),
        events.isLoading ?? true
            ? Container(
                color: Colors.red,
                width: 100,
                height: 100,
                child: CupertinoActivityIndicator(),
              )
            : SizedBox(),
      ],
    );
  }

  Widget _allEvents(Event event, BuildContext context) {
    return Container(
      height: 100.0,
      color: Colors.black,
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailsPage(
                id: event.id,
                bgImage: event.image,
              ),
            ),
          );
        },
        child: Row(
          children: <Widget>[
            //All Events Image
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              child: Container(
                child: CachedNetworkImage(
                  imageUrl: event.image,
                  width: 165,
                  height: 100,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, _, __) =>
                      CupertinoActivityIndicator(),
                  errorWidget: (context, _, __) => Image(
                    image: AssetImage("images/logo.png"),
                  ),
                ),
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
      ),
    );
  }
}
