import 'dart:convert';

import 'package:fahrenheit/api/API.dart';
import 'package:fahrenheit/api/APIService.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class Artist {
  int id;
  String name, primaryContact, secondaryContact, profileImage, coverImage;
  bool isAvailable, isPopularArtist, isMain;
  Artist(Map<String, dynamic> json) {
    this.id = json['guest_artist']['id'];
    this.name = json['guest_artist']['name'];
    this.primaryContact = json['guest_artist']['primary_contact'];
    this.secondaryContact = json['guest_artist']['secondary_contact'];
    this.profileImage = json['guest_artist']['profile_image'];
    this.coverImage = json['guest_artist']['cover'];
    this.isAvailable = json['guest_artist']['is_available'];
    this.isPopularArtist = json['guest_artist']['is_popular_artist'];
    this.isMain = json['is_main'];
  }
}

class EventDetail {
  int id, club;
  String title, description, location, image;
  DateTime startDate, endDate;
  List<Artist> artists = [];
  mapFromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.title = json['event_title'];
    this.description = json['description'];
    this.location = json['location'];
    this.startDate = DateTime.parse(json['start_date']);
    this.endDate = DateTime.parse(json['end_date']);
    this.image = json['image'];
    this.club = json['club'];
    List<dynamic> artist = json['event_artist'];
    artist.forEach((element) {
      Artist artist = new Artist(element);
      artists.add(artist);
    });
  }

  fetchData(int id) async {
    print(id);
    API api = APIService();
    Response response = await api.getApi(endpoint: "api/event-detail/$id/");
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(json);
      this.mapFromJson(json);
    } else {
      Fluttertoast.showToast(msg: "Error");
    }
  }
}
