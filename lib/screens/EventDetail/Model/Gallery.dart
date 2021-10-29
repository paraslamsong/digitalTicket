import 'dart:convert';

import 'package:fahrenheit/api/API.dart';
import 'package:fahrenheit/api/APIService.dart';
import 'package:http/http.dart';

class Image {
  int id;
  String event, title, image, tags;
  mapToObject(Map<String, dynamic> json) {
    this.id = json['id'];
    this.event = json['event'];
    this.title = json['gallery_title'];
    this.image = json['image'];
    this.tags = json['tags'];
    this.id = json['id'];
  }
}

class Gallery {
  List<Image> gallery = [];
  mapToObject(List<dynamic> json) {
    json.forEach((element) {
      Image image = new Image();
      image.mapToObject(element);
      gallery.add(image);
    });
  }

  fetchImages(int id) async {
    API api = new APIService();
    Response response =
        await api.getApi(endpoint: "api/event-galleries/?event_id=$id");
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      mapToObject(json);
    }
  }
}
