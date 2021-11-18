import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahrenheit/screens/EventDetail/EventDetailsPage.dart';
import 'package:fahrenheit/screens/MyTickets/Model/Tickets.dart';
import 'package:fahrenheit/service/RemainderService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

//Custom Package

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
                        progressIndicatorBuilder: (context, _, __) =>
                            CupertinoActivityIndicator(),
                        errorWidget: (context, _, __) =>
                            Image(image: AssetImage("images/logo.png")),
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
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "${DateFormat('EEEE').format(widget.ticket.date)}, ${DateFormat('hh:mmaa').format(widget.ticket.date).toLowerCase()}",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            SizedBox(height: 3.0),
                            Row(
                              children: [
                                Image(
                                  image:
                                      AssetImage("assets/icons/location.png"),
                                  width: 8,
                                  height: 11,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  widget.ticket.location,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                        color: Color(0xff46C2FF),
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 30.0),
          Center(
            child: Text(
              "${DateFormat('dd.MM.yy').format(widget.ticket.date)} at ${DateFormat('hh.mmaa').format(widget.ticket.date)}",
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontFamily: "Helvetica Neue",
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
              height: 18, width: double.infinity, color: Color(0xff2B2B2B)),
          SizedBox(height: 30.0),
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
              SizedBox(height: 20.0),
              Text(
                widget.ticket.userName,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontFamily: "Helvetica Neue",
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Text(
                widget.ticket.ticketNumber,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontFamily: "Helvetica Neue",
                      fontWeight: FontWeight.w500,
                    ),
              )
            ],
          ),
          SizedBox(height: 20.0),
          Container(
              height: 18, width: double.infinity, color: Color(0xff2B2B2B)),
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        var style = ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        );
                        return Dialog(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Set reminder"),
                              TextButton(
                                style: style,
                                child: Text("1 Day before the event"),
                                onPressed: () {
                                  Remender remender = Remender();
                                  remender.setRemender(context,
                                      date: widget.ticket.date
                                          .subtract(Duration(days: 1)));
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                style: style,
                                child: Text("2 hours before the event"),
                                onPressed: () {
                                  Remender remender = Remender();
                                  remender.setRemender(context,
                                      date: widget.ticket.date
                                          .subtract(Duration(hours: 2)));
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                style: style,
                                child: Text("1 hours before the event"),
                                onPressed: () {
                                  Remender remender = Remender();
                                  remender.setRemender(context,
                                      date: widget.ticket.date
                                          .subtract(Duration(hours: 1)));
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: Text("Cancel"),
                                style: style,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Text(
                  "Set Reminder",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontFamily: "SF Pro",
                    fontSize: 16,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventDetailsPage(
                            id: widget.ticket.eventId,
                            bgImage: widget.ticket.image)),
                  );
                },
                child: Text(
                  "View Detail",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontFamily: "SF Pro",
                    fontSize: 16,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 40.0),
        ],
      ),
    );
  }
}
