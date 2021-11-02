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
    image = json['image'] ?? "";
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
  int page = 1;

  Future<void> fetchTodaysEvent() async {
    Response response = await HTTP().get(path: "all-event/?pagination=1");
    if (response.statusCode == 200) {
      var result = response.data;
      result['results'].forEach((element) {
        events.add(new Event(element));
      });
    }
  }

  Future<void> fetchAllEvent() async {
    if (this.hasNext) {
      this.hasNext = true;
      Response response = await HTTP().get(path: "all-event/?pagination=$page");
      print(response.statusCode);
      if (response.statusCode == 200) {
        var result = response.data;
        result['results'].forEach((element) {
          events.add(new Event(element));
        });
        page++;
        // this.hasNext = result['next'] != null ? true : false;

      }
    }
    this.isLoading = false;
  }

  void reload() {
    this.isLoading = true;
    this.hasNext = true;
    this.events = [];
    this.fetchAllEvent();
  }

  Events() {
    this.reload();
  }

  copy(Events events) {
    this.events = events.events;
    this.hasNext = events.hasNext;
    this.isLoading = events.isLoading;
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
