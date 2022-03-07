import 'package:dio/dio.dart';
import 'package:fahrenheit/api/HTTP.dart';
import 'package:fahrenheit/bloc/BlocState.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/src/provider.dart';

class Artist {
  int id;
  String name, image;
  bool isMain;
  fromMap(json) {
    this.id = json['id'] ?? 0;
    this.name = json['artist_name'] ?? "";
    this.isMain = json['is_main'] ?? false;
    this.image = json['image'] ?? "";
  }
}

class Rate {
  int id = 0;
  String name = "", image = "";
  double rate = 0.0;
  int eventId = 0;
  fromMap(json, eventId) {
    this.id = json['id'] ?? 0;
    this.name = json['title'] ?? "";
    this.rate = json['rate'] ?? 0.0;
    this.image = json['image'] ?? "";
    this.eventId = eventId;
  }
}

class Schedule {
  int id;
  String name;
  DateTime startDate, endDate;
  fromMap(json) {
    this.id = 0;
    this.name = json['title'] ?? "";
    this.startDate = DateTime.parse(json['start_date']).toLocal();
    this.endDate = DateTime.parse(json['end_date']).toLocal();
  }
}

class Package {
  int id = 0, eventId = 0;
  DateTime startDate, endDate;
  Package() {}
  Package.fromJson(json) {
    this.id = json["id"] ?? 0;
    this.eventId = json['event'] ?? 0;
    this.startDate = DateTime.parse(json['start_date']).toLocal();
    this.endDate = DateTime.parse(json['end_date']).toLocal();
  }
  Map<dynamic, dynamic> toJson() {
    return {
      "id": this.id,
      "start_date": this.startDate.toIso8601String(),
      "end_date": this.endDate.toIso8601String(),
      "event": this.eventId
    };
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
  List<Package> packages = [];
  bool isLiked = false;

  fetchData(BuildContext context, {@required int id}) async {
    Response response = await HTTP().get(
      context: context,
      path: "event-detail/$id/",
      useToken: context.read<SessionCubit>().state,
    ); //?token=" + User().getAcess());
    if (response.statusCode == 200) {
      var json = response.data;
      this.id = json['id'] ?? 0;
      this.title = json['event_title'] ?? "";
      this.organizer = json['event_organizer'] ?? "";
      this.location = json['location'] ?? "";
      this.image = json['image'] ?? "";
      this.startDate = DateTime.parse(json['start_date']).toLocal();
      this.endDate = DateTime.parse(json['end_date']).toLocal();
      this.description = json['description'] ?? "";
      this.likes = json['likes'] ?? 0;
      this.isLiked = json['user_liked'] ?? false;
      json['event_artist'].forEach((json) {
        Artist artist = Artist();
        artist.fromMap(json);
        this.artists.add(artist);
      });

      json['event_rate'].forEach((json) {
        Rate rate = Rate();
        rate.fromMap(json, id);
        this.rates.add(rate);
      });
      json['event_schedule'].forEach((json) {
        Schedule schedule = Schedule();
        schedule.fromMap(json);
        this.schedules.add(schedule);
      });

      json['package'].forEach((json) {
        this.packages.add(Package.fromJson(json));
      });

      json['gallery'].forEach((json) {
        this.gallery.add(json['image']);
      });
    } else {
      Fluttertoast.showToast(msg: "Error");
    }
  }
}
