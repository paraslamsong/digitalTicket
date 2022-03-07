import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahrenheit/screens/ArtistList/ArtistList.dart';
import 'package:fahrenheit/screens/EventToday/Models/Artists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

Widget popularArtist(BuildContext context) {
  final Artists artists = Artists();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20).copyWith(top: 5),
        child: Text(
          "POPULAR ARTIST",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      SizedBox(height: 17),
      FutureBuilder(
          future: artists.fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Row(
                children: [
                  SizedBox(width: 15),
                  _loading(context),
                  SizedBox(width: 30),
                  _loading(context),
                ],
              );
            } else if (snapshot.hasData) {
              List<Artist> artists = snapshot.data.artists;

              if (artists.length == 0)
                return Center(
                  child:
                      Text("No data available", style: TextStyle(fontSize: 15)),
                );
              return Container(
                height: 130,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemCount: artists.length,
                  itemBuilder: (context, index) => Container(
                    width: 70,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ArtistListScreen(artists[index].id)));
                            },
                            borderRadius: BorderRadius.circular(60),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: CachedNetworkImage(
                                imageUrl: artists[index].profileImage,
                                height: 70,
                                width: 70,
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
                          artists[index].name,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.white.withOpacity(0.8)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return kReleaseMode
                  ? SizedBox()
                  : Text(snapshot.error.toString());
            } else
              return SizedBox();
          }),
    ],
  );
}

Widget _loading(context) {
  return Shimmer.fromColors(
    child: Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(70),
      ),
    ),
    baseColor: Colors.grey[400],
    highlightColor: Colors.grey[600],
  );
}
