import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fahrenheit/api/API.dart';
import 'package:fahrenheit/api/APIService.dart';
import 'package:fahrenheit/api/HTTP.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Artist {
  int id;
  String name, primaryContact, secondaryContact, profileImage, coverImage;
  bool isAvailable, isPopularArtist, isMain;
  Artist(Map<String, dynamic> json) {
    this.id = json['id'] ?? 0;
    this.name = json['name'] ?? "";
    this.primaryContact = json['primary_contact'] ?? "";
    this.secondaryContact = json['secondary_contact'] ?? "";
    this.profileImage = json['profile_image'] ?? "";
    this.coverImage = json['cover'] ?? "";
    this.isAvailable = json['is_available'] ?? false;
    this.isPopularArtist = json['is_popular_artist'] ?? false;
    this.isMain = json['is_main'] ?? false;
  }
}

class EventDetail {
  int id, club;
  String title, description, location, image;
  DateTime startDate, endDate;
  List<Artist> artists = [];
  mapFromJson(Map<String, dynamic> json) {
    this.id = json['id'] ?? 0;
    this.title = json['event_title'] ?? "";
    this.description = json['description'] ?? "";
    this.location = json['location'] ?? "";
    this.startDate =
        DateTime.parse(json['start_date'] ?? DateTime.now().toString());
    this.endDate =
        DateTime.parse(json['end_date'] ?? DateTime.now().toString());
    this.image = json['image'] ?? "";
    this.club = json['club'] ?? 0;
    List<dynamic> artist = json['event_artist'] ?? [];
    artist.forEach((element) {
      Artist artist = new Artist(element);
      artists.add(artist);
    });
  }

  fetchData(int id) async {
    print(id);
    print("api/event-detail/$id/");
    Response response = await HTTP().get(path: "event-detail/$id/");
    if (response.statusCode == 200) {
      var json = response.data;
      print(json);
      this.mapFromJson(json);
    } else {
      Fluttertoast.showToast(msg: "Error");
    }
  }
}
