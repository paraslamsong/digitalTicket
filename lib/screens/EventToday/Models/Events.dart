import 'package:dio/dio.dart';
import 'package:fahrenheit/api/HTTP.dart';
import 'package:flutter/material.dart';

class Event {
  int id;
  String eventTitle, description, location;
  DateTime startDate, endDate;
  String image;
  var user;
  String club;
  var likes;

  fromAllMap(dynamic json) {
    id = json['id'];
    eventTitle = json['event_title'] ?? "";
    description = json['description'] ?? "";
    location = json['location'] ?? "";
    startDate = DateTime.parse(json['start_date']);
    endDate = DateTime.parse(json['end_date']);
    image = json['image'] ?? "";
    user = json['user'] ?? null;
    club = json['club'] ?? "";
    likes = json['likes'] ?? null;
  }

  fromTodayMap(dynamic json) {
    id = json['id'];
    eventTitle = json['event_title'] ?? "";
    description = json['description'] ?? "";
    location = json['location'] ?? "";
    startDate = DateTime.parse(json['start_date']);
    endDate = DateTime.parse(json['end_date']);
    image = json['image'] ?? "";
    user = 0;
    club = json['club'];
    likes = 0;
  }
}

class Events {
  List<Event> events = [];
  bool hasNext = true;
  int i = 0;
  int page = 1;

  Future<Events> fetchTodaysEvent() async {
    Response response = await HTTP().get(path: "today-event/");
    if (response.statusCode == 200) {
      var result = response.data;
      result.forEach((element) {
        Event event = Event();
        event.fromTodayMap(element);
        events.add(event);
      });
    }
    return this;
  }

  Future<void> fetchAllEvent(BuildContext context) async {
    if (this.hasNext) {
      this.hasNext = true;
      Response response = await HTTP().get(
          path: "all-event/?pagination=$page",
          context: context,
          useToken: false);
      if (response.statusCode == 200) {
        var result = response.data;
        result['results'].forEach((element) {
          Event event = Event();
          event.fromAllMap(element);
          events.add(event);
        });
        page++;
        this.hasNext = result['next'] != null ? true : false;
      }
    }
  }
}
