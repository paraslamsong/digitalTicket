import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:fahrenheit/screens/MyTickets/Model/Tickets.dart';
import 'package:fahrenheit/screens/MyTickets/TicketDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyTicket extends StatefulWidget {
  @override
  _MyTicketState createState() => _MyTicketState();
}

class _MyTicketState extends State<MyTicket> {
  Tickets tickets = Tickets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('MY TICKETS'),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        children: [
          SizedBox(height: 25.0),
          Text(
            "UPCOMING EVENTS",
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          SizedBox(height: 20.0),
          FutureBuilder<Tickets>(
              future: tickets.fetchTickets(2),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.tickets.length,
                    itemBuilder: (context, index) =>
                        TicketBox(index, snapshot.data.tickets[index]),
                  );
                } else
                  return SizedBox();
              }),
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Text(
              "PAST EVENTS",
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.white,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => Divider(
                      color: Colors.black,
                      height: 30.0,
                    ),
                shrinkWrap: true,
                padding: const EdgeInsets.all(0.0),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 150.0,
                    color: Colors.black,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                            child: Container(
                              /* width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.width,*/

                              child: Image.asset("images/dance.jpg",
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  height: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "All you can drink Party",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.0),
                                  ),
                                  Text(
                                    "Beer Pong challenge vol2\nwith exciting Offers and Live\nmusic from different artist.",
                                    style: TextStyle(
                                        fontSize: 11.0, color: Colors.white),
                                  ),
                                  Text(
                                    "Saturday, 11:00pm",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10.0),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.blueAccent,
                                        size: 15.0,
                                      ),
                                      Text(
                                        "Fahrenheit, Thamel",
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 10.0),
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
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class TicketBox extends StatefulWidget {
  final int index;
  final Ticket ticket;
  TicketBox(this.index, this.ticket);
  @override
  State<TicketBox> createState() => _TicketState();
}

class _TicketState extends State<TicketBox> {
  bool isExpanded = false;
  Color color = Color(Random().nextInt(0xffffffff)).withOpacity(1);
  ExpandableController controller = ExpandableController();
  @override
  Widget build(BuildContext context) {
    return Container(
      transform:
          Matrix4.translationValues(0.0, widget.index == 0 ? 0 : -0.0, 0.0),
      child: ExpandablePanel(
        controller: controller,
        theme: ExpandableThemeData(
            iconPadding: EdgeInsets.zero, useInkWell: false, hasIcon: false),
        header: Material(
          elevation: widget.index.toDouble(),
          color: Colors.black,
          shadowColor: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
          child: Container(
            // transform:
            //     Matrix4.translationValues(0.0, widget.index * -5.0, 0.0),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8)
                .copyWith(bottom: 5),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
              gradient: RadialGradient(
                colors: [
                  color.withAlpha(100),
                  color.withAlpha(130),
                  color.withAlpha(170),
                  color.withAlpha(210),
                  color.withAlpha(220),
                  color.withAlpha(235),
                  color.withAlpha(240),
                  // color,
                ].reversed.toList(),
                radius: 3.7,
                stops: [0.1, 0.15, 0.22, 0.4, 0.6, 0.7, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.ticket.title,
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                      Text(
                        "Door Opens",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "${DateFormat('dd.MM.yy').format(widget.ticket.date)} at ${DateFormat('hh.mmaa').format(widget.ticket.date)}",
                          style: TextStyle(color: Colors.white)),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.white,
                            size: 18.0,
                          ),
                          Text(
                            DateFormat(' hh:mm').format(widget.ticket.date
                                .subtract(Duration(minutes: 30))),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        expanded: Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: InkWell(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TicketDetailPage(
                            ticket: widget.ticket,
                          )));
            },
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  height: 156.0,
                  decoration: BoxDecoration(
                    // color: Color(0xff1C1C1E),
                    color: color.withAlpha(100),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(6)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: widget.ticket.image,
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Container(
                                color: Colors.black38,
                                child: Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        widget.ticket.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        "${DateFormat('EEEE').format(widget.ticket.date)}, ${DateFormat('hh:mmaa').format(widget.ticket.date).toLowerCase()}",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                "assets/icons/location.png"),
                                            width: 7,
                                            height: 10,
                                          ),
                                          SizedBox(width: 6),
                                          Text(
                                            widget.ticket.location,
                                            style: TextStyle(
                                              color: Color(0xff46C2FF),
                                              fontSize: 8,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Hero(
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
                                size: 110.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: -13,
                  top: 50,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(26)),
                  ),
                ),
                Positioned(
                  right: -13,
                  top: 50,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(26)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
