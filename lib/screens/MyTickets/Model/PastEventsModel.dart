import 'package:dio/dio.dart';
import 'package:fahrenheit/api/HTTP.dart';
import 'package:flutter/material.dart';

class PastEvent {
  int id;
  String eventTitle, eventDescription, eventImage, location;
  DateTime dateTime;
  fromJson(json) {
    this.id = json['event_id'];
    this.eventTitle = json['event_title'];
    this.eventDescription = "";
    this.eventImage = json['event_image'];
    this.location = json['location'];
    this.dateTime = DateTime.parse(json['start_date']).toLocal();
  }
}

class PastEventList {
  List<PastEvent> list = [];
  Future<PastEventList> fetchList(BuildContext context) async {
    Response response = await HTTP()
        .get(context: context, path: "view-past-ticket/", useToken: true);
    if (response.statusCode == 200) {
      List<dynamic> result = response.data;
      this.list = [];
      result.forEach((json) {
        PastEvent pastEvent = PastEvent();
        pastEvent.fromJson(json);
        this.list.add(pastEvent);
      });
    }
    return this;
  }
}
