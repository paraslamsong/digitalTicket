import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:fahrenheit/api/HTTP.dart';
import 'package:fahrenheit/bloc/BlocState.dart';
import 'package:fahrenheit/screens/EventDetail/Model/EventDetail.dart';
import 'package:fahrenheit/screens/EventDetail/Widgets/EventDetailText.dart';
import 'package:fahrenheit/screens/GalleryView/GalleryView.dart';
import 'package:fahrenheit/screens/BuyTicket/Ticket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

class EventDetailsPage extends StatefulWidget {
  final int id;
  final String bgImage;
  EventDetailsPage({this.id, this.bgImage});
  @override
  _ArtistDetailsPageState createState() => _ArtistDetailsPageState();
}

class _ArtistDetailsPageState extends State<EventDetailsPage> {
  final key = GlobalKey();
  final _descriptionKey = GlobalKey<EventDetailDescriptionState>();

  @override
  void initState() {
    super.initState();
  }

  Future<EventDetail> fetchDetail() async {
    EventDetail eventDetail = new EventDetail();
    await eventDetail.fetchData(context, id: widget.id);
    return Future.value(eventDetail);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              widget.bgImage != null
                  ? CachedNetworkImage(
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: widget.bgImage,
                      progressIndicatorBuilder: (context, _, __) =>
                          CupertinoActivityIndicator(),
                      errorWidget: (context, _, __) => Image(
                        fit: BoxFit.cover,
                        image: AssetImage("images/background_image.jpeg"),
                      ),
                    )
                  : SizedBox(),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 13.0, sigmaY: 13.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(elevation: 0),
          body: RefreshIndicator(
            onRefresh: () async {
              key.currentState.build(context);
              setState(() {});
            },
            child: FutureBuilder(
                key: key,
                future: fetchDetail(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    EventDetail event = snapshot.data;
                    print(event);
                    return ListView(
                      children: [
                        _eventTitle(event),
                        _eventDetail(event),
                        _eventBuyBox(event),
                        SizedBox(height: 10),
                        _eventGuestArtist(event),
                        _eventSchedule(event),
                        _eventGallery(event),
                      ],
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else
                    return Center(
                        child: Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(color: Colors.red),
                    ));
                }),
          ),
        ),
      ],
    );
  }

  Widget _eventTitle(EventDetail event) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            event.title,
            maxLines: 2,
            style: GoogleFonts.openSans().copyWith(
                color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            event.organizer + ", " + event.location,
            style: GoogleFonts.openSans()
                .copyWith(color: Colors.white.withOpacity(0.8), fontSize: 13),
          ),
          SizedBox(height: 3),
          Text(
            DateFormat("dd/MM/yyyy, HH:mm").format(event.startDate) +
                " - " +
                DateFormat("dd/MM/yyyy, HH:mm").format(event.endDate),
            style: GoogleFonts.openSans()
                .copyWith(color: Colors.white.withOpacity(0.8), fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _eventDetail(EventDetail event) {
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      color: Colors.black38,
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: event.image,
            height: 220,
            width: 150,
            fit: BoxFit.cover,
            placeholder: (context, _) => Center(
              child: CupertinoActivityIndicator(),
            ),
            errorWidget: (context, _, __) => Icon(Icons.error),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: EventDetailDescription(
                        detail: event.description, key: _descriptionKey),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // InkWell(
                      //   onTap: () {},
                      //   radius: 10,
                      //   child: Text(
                      //     "Hide/Show more",
                      //     style: GoogleFonts.openSans(
                      //         color: Colors.white.withOpacity(0.8),
                      //         fontSize: 11),
                      //   ),
                      // ),
                      Spacer(),
                      // Icon(Icons.thumb_up, color: Colors.white60, size: 18),
                      SizedBox(width: 5),
                      Text(
                        event.likes.toString(),
                        style: GoogleFonts.openSans(
                            color: Colors.white.withOpacity(0.8), fontSize: 9),
                      ),
                      // SizedBox(width: 10),
                      BlocBuilder<SessionCubit, bool>(
                        builder: (context, state) => Visibility(
                          visible: state,
                          child: IconButton(
                            onPressed: () async {
                              Response response = await HTTP().post(
                                  path: "like-event/",
                                  body: {"event": event.id},
                                  useToken: true);
                              if (response.statusCode == 200) setState(() {});
                            },
                            iconSize: 18,
                            constraints: BoxConstraints(minWidth: 30),
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              event.isLiked
                                  ? CupertinoIcons.heart_fill
                                  : CupertinoIcons.heart,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          Share.share('https://www.meroticketapp.com/');
                        },
                        padding: EdgeInsets.zero,
                        iconSize: 18,
                        constraints: BoxConstraints(minWidth: 40),
                        visualDensity: VisualDensity.compact,
                        icon: ImageIcon(
                          AssetImage("assets/icons/share.png"),
                          color: Color(0xffFFF156),
                          size: 17,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _eventBuyBox(EventDetail event) {
    return Container(
      padding: EdgeInsets.only(right: 20, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: event.rates.length,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Spacer(),
                      Text(
                        event.rates[index].name,
                        style: GoogleFonts.openSans(
                            color: Colors.white.withOpacity(0.8), fontSize: 13),
                      ),
                      Text(
                        "रू " +
                            double.parse(event.rates[index].rate.toString())
                                .toStringAsFixed(2),
                        style: GoogleFonts.openSans(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 11,
                            fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 18),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TicketPage(
                            event.rates, event.organizer, event.id)));
              },
              child: Text("Buy ticket",
                  style: GoogleFonts.openSans(
                      color: Color(0xffFAFBFD), fontSize: 13))),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 20).copyWith(top: 5),
                  child: Text(
                    "Performing Artists",
                    style: Theme.of(context).textTheme.headline2.copyWith(
                        fontFamily: GoogleFonts.openSans().fontFamily),
                  ),
                ),
                Container(
                  height: 130,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
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
                                  imageUrl: event.artists[index].image,
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder: (context, _, __) =>
                                      CupertinoActivityIndicator(),
                                  errorWidget: (context, _, __) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 7),
                          Text(
                            event.artists[index].name,
                            maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                  fontFamily: GoogleFonts.openSans().fontFamily,
                                ),
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

  Widget _eventSchedule(EventDetail event) {
    List<Schedule> schedules = event.schedules;
    return Visibility(
      visible: schedules.length > 0,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 20).copyWith(top: 5, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Schedule",
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(fontFamily: GoogleFonts.openSans().fontFamily),
            ),
            SizedBox(height: 5),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Text(
                        schedules[index].name,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontFamily: GoogleFonts.openSans().fontFamily),
                      ),
                      Spacer(),
                      Text(
                        DateFormat("dd/M/yyyy, HH:MM")
                            .format(schedules[index].startDate),
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontFamily: GoogleFonts.openSans().fontFamily),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _eventGallery(EventDetail event) {
    return Visibility(
      visible: event.gallery.length > 0,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Event Images",
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(fontFamily: GoogleFonts.openSans().fontFamily),
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: 95,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                itemCount: event.gallery.length,
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: () {
                      List<String> images = [];
                      event.gallery.forEach((element) {
                        images.add(element);
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  GalleryPage(images: images, index: index)));
                    },
                    child: Hero(
                      tag: event.gallery[index] + index.toString(),
                      child: CachedNetworkImage(
                        height: 95,
                        imageUrl: event.gallery[index],
                        placeholder: (context, _) => Container(
                            width: 100,
                            child: Center(child: CupertinoActivityIndicator())),
                        errorWidget: (context, _, __) => Container(
                            width: 100,
                            child: Center(child: Icon(Icons.error))),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
