import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahrenheit/screens/EventDetail/EventDetailsPage.dart';
import 'package:fahrenheit/screens/EventToday/EventsTodayPage.dart';
import 'package:fahrenheit/screens/MyTickets/Model/Tickets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:toast/toast.dart';

//Custom Package
import 'package:fahrenheit/screens/MyTickets/MyTicket.dart';

class TicketDetailPage extends StatefulWidget {
  final Ticket ticket;
  TicketDetailPage({this.ticket});
  @override
  _YourTicketPageState createState() => _YourTicketPageState();
}

class _YourTicketPageState extends State<TicketDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("YOUR TICKET"),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: Offset(4, 4),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          child: CachedNetworkImage(
                            imageUrl: widget.ticket.image,
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          color: Colors.black54,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.ticket.title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  "${DateFormat('EEEE').format(widget.ticket.date)}, ${DateFormat('hh:mmaa').format(widget.ticket.date).toLowerCase()}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10.0),
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          "assets/icons/location.png"),
                                      width: 9,
                                      height: 13,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      widget.ticket.location,
                                      style: TextStyle(
                                          color: Color(0xff46C2FF),
                                          fontSize: 10.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))),
          ),
          SizedBox(height: 20.0),
          Center(
            child: Text(
                "${DateFormat('dd.MM.yy').format(widget.ticket.date)} at ${DateFormat('hh.mmaa').format(widget.ticket.date)}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
          ),
          SizedBox(height: 10.0),
          Container(
              height: 10, width: double.infinity, color: Color(0xff2B2B2B)),
          SizedBox(height: 10.0),
          Column(
            children: [
              Hero(
                tag: "qrCode${widget.ticket.ticketId}",
                child: QrImage(
                  data: jsonEncode({
                    'ticketId': widget.ticket.ticketId,
                    'eventId': widget.ticket.eventId,
                    'eventRateId': widget.ticket.eventRateId,
                    'ticketNumber': widget.ticket.ticketNumber,
                  }),
                  foregroundColor: Colors.white,
                  version: QrVersions.auto,
                  size: 160.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                widget.ticket.userName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6.0),
              Text(
                widget.ticket.ticketNumber,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          SizedBox(height: 10.0),
          Container(
              height: 10, width: double.infinity, color: Color(0xff2B2B2B)),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Toast.show("Set Reminder", context,
                      gravity: Toast.BOTTOM,
                      duration: Toast.LENGTH_LONG,
                      backgroundColor: Colors.black);
                },
                child:
                    Text("Set Reminder", style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EventDetailsPage(id: widget.ticket.eventId)),
                  );
                },
                child:
                    Text("View Detail", style: TextStyle(color: Colors.white)),
              )
            ],
          ),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
