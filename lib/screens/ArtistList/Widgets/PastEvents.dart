import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahrenheit/screens/ArtistList/Model/Events.dart';
import 'package:fahrenheit/screens/EventDetail/EventDetailsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PastEvents extends StatefulWidget {
  final int id;
  PastEvents(this.id);
  @override
  _PastEventsState createState() => _PastEventsState();
}

class _PastEventsState extends State<PastEvents> {
  Events events = new Events();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: events.fetchFeaturedEvent(context, widget.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) => _loading(),
          );
        if (snapshot.hasData) {
          var data = snapshot.data.events;
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemCount: data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _featuredEvent(data[index]);
              });
        } else
          return Text(snapshot.error);
      },
    );
  }

  Widget _featuredEvent(Event event) {
    return Container(
      height: 170.0,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: event.image,
                        height: 170.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Center(child: Icon(Icons.error)),
                      ),
                      Container(
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.eventTitle,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        children: [
                          Image(
                            image: AssetImage("assets/icons/location.png"),
                            width: 8,
                            height: 11,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${event.location}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Color(0xff46C2FF)),
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
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
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

  Widget _loading() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey.withOpacity(0.6),
        child: Container(
          height: 170,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
