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

  fromComingSoonMap(dynamic json) {
    id = json['id'] ?? 0;
    eventTitle = json['event_title'] ?? "";
    description = json['description'] ?? "";
    location = json['location'] ?? "";
    startDate = DateTime.parse(json['start_date']).toLocal();
    endDate = DateTime.parse(json['end_date']).toLocal();
    image = json['image'] ?? "";
    user = 0;
    club = json['club'] ?? "";
    likes = 0;
  }

  fromFeaturedMap(json) {
    this.id = json['event_id'] ?? 0;
    this.eventTitle = json['featured_title'] ?? "";
    this.description = json['event_title'] ?? "";
    this.location = json['location'] ?? "";
    this.startDate = DateTime.now();
    this.endDate = DateTime.now();
    this.image = json['picture'] ?? '';
    this.user = "";
    this.club = "";
    this.likes = 0;
  }
}

class Events {
  List<Event> events = [];

  Future<Events> fetchComingEvent(BuildContext context, int id) async {
    Response response = await HTTP().get(
      path: "event-by-artist/$id/",
      context: context,
      useToken: false,
    );
    if (response.statusCode == 200) {
      var result = response.data;
      result.forEach((element) {
        this.events = [];
        Event event = Event();
        event.fromComingSoonMap(element);
        events.add(event);
      });
    }
    return this;
  }

  Future<Events> fetchFeaturedEvent(BuildContext context, int id) async {
    Response response = await HTTP().get(
      path: "feature-event-by-artist/$id/",
      context: context,
      useToken: false,
    );
    if (response.statusCode == 200) {
      var result = response.data;
      result.forEach((element) {
        this.events = [];
        Event event = Event();
        event.fromFeaturedMap(element);
        events.add(event);
      });
    }
    return this;
  }
}
