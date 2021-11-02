import 'package:fahrenheit/screens/EventToday/Bloc/AllEventCubit.dart';
import 'package:fahrenheit/screens/EventToday/Models/Events.dart';
import 'package:fahrenheit/screens/EventToday/Streams/AllEventsStream.dart';
import 'package:fahrenheit/screens/EventToday/Widgets/AllEvents.dart';
import 'package:fahrenheit/screens/EventToday/Widgets/TodaysEvents.dart';
import 'package:fahrenheit/screens/MyTickets/MyTicket.dart';
import 'package:fahrenheit/screens/Profile/Profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    // Future.delayed(Duration(seconds: 6), () {
    // context.read<AllEventsCubit>().reload();
    // });

    // SchedulerBinding.instance
    //     .addPostFrameCallback((_) =>context.read<AllEventsCubit>().reload() );

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        BlocProvider.of<AllEventsCubit>(context).loadMore();
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
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              icon: Icon(Icons.account_box_rounded),
            ),
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
          context.read<AllEventsCubit>().reload();
        },
        child: ListView(
          controller: _scrollController,
          shrinkWrap: false,
          children: [
            EventToday(),
            BlocBuilder<AllEventsCubit, Events>(
              builder: (context, state) {
                print(state.hasNext);
                return AllEvents(state);
              },
            ),
          ],
        ),
      ),
    );
  }
}
