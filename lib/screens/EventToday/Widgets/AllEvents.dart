import 'package:cached_network_image/cached_network_image.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "ALL EVENTS",
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        SizedBox(height: 20.0),
        ListView.builder(
          physics: ScrollPhysics(),
          itemCount: this.events.events.length,
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              _allEvents(this.events.events[index], context),
        ),
      ],
    );
  }

  Widget _allEvents(Event event, BuildContext context) {
    return Container(
      height: 120.0,
      color: Colors.black,
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Stack(
        children: [
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
                child: Container(
                  child: CachedNetworkImage(
                    imageUrl: event.image,
                    width: 160,
                    height: 120,
                    fit: BoxFit.cover,
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
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.eventTitle,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(height: 6),
                      Expanded(
                        child: Text(
                          event.description,
                          maxLines: 3,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        event.startDate.isAfter(
                                DateTime.now().subtract(Duration(days: 1)))
                            ? DateFormat("EEEE, hh:mmaa")
                                .format(event.startDate)
                            : DateFormat("EEEE, MMM dd, yyyy, hh:mmaa")
                                .format(event.startDate),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Image(
                            image: AssetImage("assets/icons/location.png"),
                            width: 8,
                            height: 11,
                          ),
                          SizedBox(width: 3),
                          Text(
                            "${event.location}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Color(0xff46C2FF)),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 5),
            ],
          ),
          TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: () {
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
            child: Container(
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
