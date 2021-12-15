import 'dart:convert';

FeaturedEventsModel featuredEventsModelFromJson(String str) =>
    FeaturedEventsModel.fromJson(json.decode(str));

String featuredEventsModelToJson(FeaturedEventsModel data) =>
    json.encode(data.toJson());

class FeaturedEventsModel {
  FeaturedEventsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory FeaturedEventsModel.fromJson(Map<String, dynamic> json) =>
      FeaturedEventsModel(
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
    this.event,
    this.featuredTitle,
    this.description,
    this.startDate,
    this.endDate,
  });

  int id;
  Event event;
  String featuredTitle;
  String description;
  DateTime startDate;
  DateTime endDate;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        event: Event.fromJson(json["event"]),
        featuredTitle: json["featured_title"],
        description: json["description"],
        startDate: DateTime.parse(json["start_date"]).toLocal(),
        endDate: DateTime.parse(json["end_date"]).toLocal(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event": event.toJson(),
        "featured_title": featuredTitle,
        "description": description,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
      };
}

class Event {
  Event({
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

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        eventTitle: json["event_title"],
        description: json["description"],
        location: json["location"],
        startDate: DateTime.parse(json["start_date"]).toLocal(),
        endDate: DateTime.parse(json["end_date"]).toLocal(),
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
