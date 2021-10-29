import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fahrenheit/api/API.dart';
import 'package:fahrenheit/api/APIService.dart';
import 'package:fahrenheit/api/HTTP.dart';

class Event {
  int id;
  String eventTitle, description, location, startDate, endDate;
  String image;
  var user;
  int club;
  var likes;

  Event(dynamic json) {
    id = json['id'];
    eventTitle = json['event_title'] ?? "";
    description = json['description'] ?? "";
    location = json['location'] ?? "";
    startDate = json['start_date'] ?? "";
    endDate = json['end_date'] ?? "";
    image = HTTP().getImageBase() + json['image'] ?? "";
    user = json['user'] ?? null;
    club = json['club'] ?? 0;
    likes = json['likes'] ?? null;
  }
}

class Events {
  List<Event> events = [];
  bool isLoading = true;
  bool hasNext = true;
  int i = 0;

  Future<void> fetchTodaysEvent() async {
    Response response = await HTTP().get(path: "all-event/?limit=5");
    if (response.statusCode == 200) {
      List<dynamic> result = response.data;
      result.forEach((element) {
        events.add(new Event(element));
      });
    }
  }

  Future<void> fetchAllEvent() async {
    Response response = await HTTP().get(path: "all-event/?limit=5");
    if (response.statusCode == 200) {
      List<dynamic> result = response.data;
      result.forEach((element) {
        events.add(new Event(element));
      });
    }
    this.isLoading = false;
    i++;
    if (i != 0) this.hasNext = false;
  }

  void reload() {
    this.isLoading = true;
    this.hasNext = true;
    this.events = [];
    this.fetchAllEvent();
  }

  Events() {
    reload();
  }

  Future<void> fetchFeaturedEvent() async {
    Response response = await HTTP().get(path: "all-event/");
    // if (response.statusCode == 200) {
    //   List<dynamic> result = jsonDecode(response.body);
    //   result.forEach((element) {
    //     events.add(new Event(element));
    //   });
    // }
  }
}
