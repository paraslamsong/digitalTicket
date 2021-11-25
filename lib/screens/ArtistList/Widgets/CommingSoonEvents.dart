import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahrenheit/screens/EventDetail/EventDetailsPage.dart';
import 'package:fahrenheit/screens/EventToday/Models/Events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

Widget commingSoonEvents(BuildContext context) {
  final Events events = new Events();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 20.0),
      FutureBuilder(
        future: events.fetchTodaysEvent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data.events;
            return Container(
              height: 202,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(0.0),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) =>
                    _eventSlideShow(context, data[index]),
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 30);
                },
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return _loading();
          } else
            return Text(snapshot.error.toString());
        },
      ),
      SizedBox(height: 40),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Divider(),
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

Widget _eventSlideShow(BuildContext context, Event event) {
  return Container(
    width: 400,
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          child: CachedNetworkImage(
            imageUrl: event.image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, _) => Center(
              child: CupertinoActivityIndicator(),
            ),
            errorWidget: (context, _, __) =>
                Image(image: AssetImage("images/logo.png")),
          ),
        ),
        Container(
          color: Colors.black45,
        ),
        _calendarBox(event.startDate),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.eventTitle,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 5),
                Text(
                  DateFormat("EEEE, hh:mma")
                      .format(DateTime.parse(event.startDate.toString())),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontFamily: "SF Pro",
                  ),
                ),
                SizedBox(height: 5.0),
                Row(
                  children: [
                    Image(
                      image: AssetImage(
                        "assets/icons/location.png",
                      ),
                      width: 10,
                      height: 12,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "${event.club}, ${event.location}",
                      style: TextStyle(
                          fontFamily: "SF Pro",
                          color: Color(0xff46C2FF),
                          fontSize: 12.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        TextButton(
          child: Container(),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EventDetailsPage(id: event.id, bgImage: event.image),
                ));
          },
        ),
      ],
    ),
  );
}

Widget _calendarBox(DateTime date) {
  return Positioned(
    top: 20,
    left: -13,
    child: Container(
      padding: EdgeInsets.all(6),
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
          fontFamily: "SF Pro",
          color: Color(0xffF4F4F4),
          fontSize: 12,
        ),
      ),
    ),
  );
}
