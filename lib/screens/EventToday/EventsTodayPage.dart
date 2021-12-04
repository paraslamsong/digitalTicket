import 'package:fahrenheit/model/User.dart';
import 'package:fahrenheit/screens/EventToday/Models/Events.dart';
import 'package:fahrenheit/screens/EventToday/Streams/AllEventsStream.dart';
import 'package:fahrenheit/screens/EventToday/Widgets/AllEvents.dart';
import 'package:fahrenheit/screens/EventToday/Widgets/FeaturedEvents.dart';
import 'package:fahrenheit/screens/EventToday/Widgets/PopularArtists.dart';
import 'package:fahrenheit/screens/EventToday/Widgets/TodaysEvents.dart';
import 'package:fahrenheit/screens/MyTickets/MyTicket.dart';
import 'package:fahrenheit/screens/Profile/Profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventsTodayPage extends StatelessWidget {
  final AllEventsModelBuilder allEventsModelBuilder = AllEventsModelBuilder();

  final ScrollController _scrollController =
      ScrollController(debugLabel: "Debug");

  @override
  Widget build(BuildContext context) {
    allEventsModelBuilder.eventSink.add(
        AllEventsListener(action: EventsActions.refresh, context: context));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          _scrollController.position.pixels != 0) {
        allEventsModelBuilder.eventSink.add(AllEventsListener(
            action: EventsActions.loadmore, context: context));
      }
    });
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "EVENTS",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: const Color(0xff867AC4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  User().getAcess() != ""
                      ? IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfileScreen()));
                          },
                          icon: Icon(Icons.account_box_rounded,
                              color: Colors.white),
                        )
                      : SizedBox(),
                  User().getAcess() != ""
                      ? IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyTicket()));
                          },
                          icon:
                              Icon(CupertinoIcons.tickets, color: Colors.white),
                        )
                      : SizedBox(),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  allEventsModelBuilder.eventSink.add(AllEventsListener(
                      action: EventsActions.refresh, context: context));
                },
                child: ListView(
                  controller: _scrollController,
                  shrinkWrap: false,
                  children: [
                    eventToday(context),
                    FeaturedEvents(),
                    popularArtist(context),
                    StreamBuilder<Events>(
                      stream: allEventsModelBuilder.stateStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data.hasNext.toString());
                          return AllEvents(snapshot.data);
                        } else if (snapshot.hasError)
                          return Text(snapshot.error);
                        else {
                          return CupertinoActivityIndicator();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
