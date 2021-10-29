import 'dart:convert';

EventsTodayModel eventsTodayModelFromJson(String str) =>
    EventsTodayModel.fromJson(json.decode(str));

String eventsTodayModelToJson(EventsTodayModel data) =>
    json.encode(data.toJson());

class EventsTodayModel {
  EventsTodayModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory EventsTodayModel.fromJson(Map<String, dynamic> json) =>
      EventsTodayModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.eventTitle,
    this.description,
    this.location,
    this.startDate,
    this.endDate,
    this.image,
    this.user,
    this.club,
    this.likes,
  });

  int id;
  String eventTitle;
  String description;
  String location;
  DateTime startDate;
  DateTime endDate;
  String image;
  int user;
  int club;
  List<dynamic> likes;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        eventTitle: json["event_title"],
        description: json["description"],
        location: json["location"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        image: json["image"],
        user: json["user"],
        club: json["club"],
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event_title": eventTitle,
        "description": description,
        "location": location,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "image": image,
        "user": user,
        "club": club,
        "likes": List<dynamic>.from(likes.map((x) => x)),
      };
}
