import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahrenheit/constraints/constants.dart';
import 'package:fahrenheit/screens/EventDetail/Model/EventDetail.dart';
import 'package:fahrenheit/screens/EventDetail/Model/Gallery.dart';
import 'package:fahrenheit/screens/EventDetail/Model/Tickets.dart';
import 'package:fahrenheit/screens/TableBooking/TableBookingPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailsPage extends StatefulWidget {
  int id;
  EventDetailsPage({this.id});
  @override
  _ArtistDetailsPageState createState() => _ArtistDetailsPageState();
}

class _ArtistDetailsPageState extends State<EventDetailsPage> {
  final key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  Future<EventDetail> fetchDetail() async {
    EventDetail eventDetail = new EventDetail();
    await eventDetail.fetchData(widget.id);
    return Future.value(eventDetail);
  }

  fetchImages() async {
    Gallery gallery = new Gallery();
    await gallery.fetchImages(widget.id);
    return Future.value(gallery);
  }

  fetchPrices() async {
    Tickets tickets = new Tickets();
    await tickets.fetchTickets(widget.id);
    return Future.value(tickets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0),
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 25.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                size: 25.0,
              ),
              onPressed: () {})
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          key.currentState.build(context);
          setState(() {});
        },
        child: FutureBuilder(
            key: key,
            future: fetchDetail(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError)
                return Center(
                    child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.red),
                ));
              else {
                EventDetail event = snapshot.data;
                print(event);
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(APIURL + event.image),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black,
                        BlendMode.overlay,
                      ),
                    ),
                  ),
                  child: BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                    child: new ListView(
                      children: [
                        _eventTitle(event),
                        _eventDetail(event),
                        _eventBuyBox(event),
                        _eventGuestArtist(event),
                        _eventReservation(),
                        _eventGallery(event.id),
                      ],
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }

  Widget _eventTitle(EventDetail event) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.title,
            style: TextStyle(color: Colors.white, fontSize: 23),
          ),
          Text(
            CLUB_NAME + ", " + event.location,
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
          SizedBox(height: 8),
          Text(
            DateFormat("MMM dd, yyyy, HH:mm").format(event.startDate) +
                " - " +
                DateFormat("MMM dd, yyyy, HH:mm").format(event.endDate),
            style: TextStyle(color: Colors.white, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _eventDetail(EventDetail event) {
    return Container(
      height: 220,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: APIURL + event.image,
            height: 220,
            width: 180,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    event.description,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "More info",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        CupertinoIcons.heart_fill,
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        print("Hello");
                      },
                      icon: Icon(
                        Icons.share,
                        color: Colors.red,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _eventBuyBox(EventDetail event) {
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: FutureBuilder(
                future: fetchPrices(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Row(
                      children: [
                        Container(
                          width: 120,
                          height: 95,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        Container(
                          width: 120,
                          height: 95,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError)
                    return Center(child: Text('Error: ${snapshot.error}'));
                  else {
                    var tickets = snapshot.data.tickets;
                    return Container(
                      height: 95,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: tickets.length,
                        itemBuilder: (context, index) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Text(
                                tickets[index].title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "रू " + tickets[index].rate,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }),
          ),
          SizedBox(width: 10),
          TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xff2FBCA1)),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 20, vertical: 16))),
              onPressed: () {},
              child: Text("Buy ticket", style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }

  Widget _eventGuestArtist(EventDetail event) {
    return Container(
      child: event.artists.length == 0
          ? SizedBox()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Guest Artists",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  height: 150,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: event.artists.length,
                    itemBuilder: (context, index) => Container(
                      width: 65,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(
                                event.artists[index].isMain ? 2 : 0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(60),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: CachedNetworkImage(
                                  imageUrl: APIURL +
                                      event.artists[index].profileImage,
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            event.artists[index].name,
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _eventReservation() {
    var _reservationButtonStyle = ButtonStyle(
      padding: MaterialStateProperty.all(EdgeInsets.all(15)),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      alignment: Alignment.center,
      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 13)),
      backgroundColor: MaterialStateProperty.all(Color(0xff141313)),
    );

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Event Detail",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: _reservationButtonStyle,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TableBookingPage()));
                },
                child: Text("Table\nReservation", textAlign: TextAlign.center),
              ),
              TextButton(
                style: _reservationButtonStyle,
                onPressed: () {},
                child: Text("Couple\nReservation", textAlign: TextAlign.center),
              ),
              TextButton(
                style: _reservationButtonStyle,
                onPressed: () {},
                child: Text("VIP\nAccess", textAlign: TextAlign.center),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _eventGallery(int id) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Event Images",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 15),
          Container(
            height: 95,
            child: FutureBuilder(
                future: fetchImages(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Row(
                      children: [
                        Container(
                          width: 120,
                          height: 95,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        Container(
                          width: 120,
                          height: 95,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError)
                    return Center(child: Text('Error: ${snapshot.error}'));
                  else {
                    var gallery = snapshot.data.gallery;
                    if (gallery.length == 0)
                      return Center(
                        child: Text(
                          "Not Available",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: gallery.length,
                      itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: CachedNetworkImage(
                          height: 95,
                          imageUrl: gallery[index].image,
                        ),
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
