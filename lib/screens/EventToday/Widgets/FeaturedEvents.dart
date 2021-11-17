import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahrenheit/constraints/constants.dart';
import 'package:fahrenheit/screens/EventDetail/EventDetailsPage.dart';
import 'package:fahrenheit/screens/EventToday/Models/Events.dart';
import 'package:flutter/material.dart';

class FeaturedEvents extends StatefulWidget {
  @override
  _FeaturedEventsState createState() => _FeaturedEventsState();
}

class _FeaturedEventsState extends State<FeaturedEvents> {
  Events events = new Events();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.0),
        Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: Text(
            "FEATURED EVENT",
            style: TextStyle(
              fontFamily: "SF Pro",
              fontSize: 26.0,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 15.0),
        FutureBuilder(
          future: events.fetchFeaturedEvent(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data.events;
              return Container(
                height: 130,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return _featuredEvent(data[index]);
                    }),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error);
            } else {
              return SizedBox();
            }
          },
        ),
        SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Divider(),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _featuredEvent(Event event) {
    return Container(
      height: 130.0,
      width: 195.0,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: event.image,
                    height: 130.0,
                    width: 195.0,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Center(child: Icon(Icons.error)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Featured Events Title
                      Text(
                        event.eventTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: const Color(0xffb74093),
                            size: 8.0,
                          ),
                          //Featured Events Location
                          Text(
                            "$CLUB_NAME, ${event.location}",
                            style: TextStyle(
                              color: const Color(0xff46C2FF),
                              fontSize: 7.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EventDetailsPage(id: event.id, bgImage: event.image),
                  ));
            },
            child: Container(),
          ),
        ],
      ),
    );
  }
}
