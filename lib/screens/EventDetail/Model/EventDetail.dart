import 'package:dio/dio.dart';
import 'package:fahrenheit/api/HTTP.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Artist {
  int id;
  String name, image;
  bool isMain;
  fromMap(json) {
    this.id = json['id'];
    this.name = json['artist_name'];
    this.isMain = json['is_main'];
    this.image = json['image'];
  }
}

class Rate {
  int id = 0;
  String name = "", image = "";
  double rate = 0.0;
  fromMap(json) {
    this.id = json['id'];
    this.name = json['title'];
    this.rate = json['rate'];
    this.image = json['image'];
  }
}

class Schedule {
  int id;
  String name;
  DateTime startDate, endDate;
  fromMap(json) {
    this.id = 0;
    this.name = json['title'];
    this.startDate = DateTime.parse(json['start_date']).toLocal();
    this.endDate = DateTime.parse(json['end_date']).toLocal();
  }
}

class EventDetail {
  int id, likes;
  String title, organizer, description, location, image;
  DateTime startDate, endDate;
  List<Artist> artists = [];
  List<Rate> rates = [];
  List<Schedule> schedules = [];
  List<String> gallery = [];
  bool isLiked = false;

  fetchData(BuildContext context, {@required int id}) async {
    Response response = await HTTP().get(
        context: context,
        path: "event-detail/$id/"); //?token=" + User().getAcess());
    if (response.statusCode == 200) {
      var json = response.data;
      this.id = json['id'];
      this.title = json['event_title'];
      this.organizer = json['event_organizer'];
      this.location = json['location'];
      this.image = json['image'];
      this.startDate = DateTime.parse(json['start_date']).toLocal();
      this.endDate = DateTime.parse(json['end_date']).toLocal();
      this.description = json['description'];
      this.likes = json['likes'];
      this.isLiked = json['user_liked'];
      json['event_artist'].forEach((json) {
        Artist artist = Artist();
        artist.fromMap(json);
        this.artists.add(artist);
      });

      json['event_rate'].forEach((json) {
        Rate rate = Rate();
        rate.fromMap(json);
        this.rates.add(rate);
      });
      json['event_schedule'].forEach((json) {
        Schedule schedule = Schedule();
        schedule.fromMap(json);
        this.schedules.add(schedule);
      });
      json['gallery'].forEach((json) {
        this.gallery.add(json['image']);
      });
    } else {
      Fluttertoast.showToast(msg: "Error");
    }
  }
}
