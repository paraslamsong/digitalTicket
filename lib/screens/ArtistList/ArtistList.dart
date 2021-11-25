import 'package:fahrenheit/screens/ArtistList/Widgets/CommingSoonEvents.dart';
import 'package:fahrenheit/screens/ArtistList/Widgets/PastEvents.dart';
import 'package:flutter/material.dart';

class ArtistListScreen extends StatelessWidget {
  final int id;
  ArtistListScreen(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Artist"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "COMING SOON",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          commingSoonEvents(context),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "FEATURED",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          SizedBox(height: 30),
          PastEvents(),
        ],
      ),
    );
  }
}
