import 'package:fahrenheit/screens/EventToday/Models/Events.dart';
import 'package:fahrenheit/screens/EventToday/Streams/AllEventsStream.dart';
import 'package:fahrenheit/screens/EventToday/Widgets/AllEvents.dart';
import 'package:fahrenheit/screens/EventToday/Widgets/TodaysEvents.dart';
import 'package:fahrenheit/screens/MyTickets/MyTicket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EventsTodayPage extends StatefulWidget {
  @override
  _EventsTodayPageState createState() => _EventsTodayPageState();
}

class _EventsTodayPageState extends State<EventsTodayPage> {
  final AllEventsModelBuilder allEventsModelBuilder = AllEventsModelBuilder();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 800), () {
      allEventsModelBuilder.eventSink
          .add(AllEventsListener(EventsActions.loadmore));
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        allEventsModelBuilder.eventSink
            .add(AllEventsListener(EventsActions.loadmore));
      }
    });
  }

  ScrollController _scrollController =
      ScrollController(keepScrollOffset: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: false,
            title: Text(
              "EVENTS",
              style: TextStyle(
                fontSize: 22.0,
                color: const Color(0xff867AC4),
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyTicket()));
                },
                icon: Icon(CupertinoIcons.tickets),
              ),
            ]),
        body: RefreshIndicator(
          onRefresh: () async {
            allEventsModelBuilder.eventSink
                .add(AllEventsListener(EventsActions.refresh));
          },
          child: ListView(
            controller: _scrollController,
            shrinkWrap: false,
            children: [
              EventToday(),
              // FeaturedEvents(),
              StreamBuilder<Events>(
                stream: allEventsModelBuilder.stateStream,
                initialData: Events(),
                builder: (context, AsyncSnapshot<Events> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data.isLoading) {
                    return Column(
                      children: [
                        AllEvents(snapshot.data),
                        Container(
                          height: 200,
                          child: Center(
                            child: Center(
                              child: Lottie.asset("assets/spinner.json",
                                  height: 200, animate: true),
                            ),
                          ),
                        )
                      ],
                    );
                  } else if (snapshot.hasData) {
                    return AllEvents(snapshot.data);
                  } else
                    return Text(snapshot.error.toString());
                },
              ),
            ],
          ),
        ));
  }
}
