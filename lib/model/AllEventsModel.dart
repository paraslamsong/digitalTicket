import 'dart:convert';

AllEventsModel allEventsModelFromJson(String str) =>
    AllEventsModel.fromJson(json.decode(str));

String allEventsModelToJson(AllEventsModel data) => json.encode(data.toJson());

class AllEventsModel {
  AllEventsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory AllEventsModel.fromJson(Map<String, dynamic> json) => AllEventsModel(
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
    this.user,
    this.club,
    this.eventTitle,
    this.description,
    this.likes,
    this.startDate,
    this.endDate,
    this.image,
    this.featureEvent,
    this.eventArtist,
    this.eventGallery,
    this.eventSchedule,
  });

  int id;
  int user;
  Club club;
  String eventTitle;
  String description;
  int likes;
  DateTime startDate;
  DateTime endDate;
  String image;
  List<FeatureEvent> featureEvent;
  List<EventArtist> eventArtist;
  List<EventGallery> eventGallery;
  List<EventSchedule> eventSchedule;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        user: json["user"],
        club: Club.fromJson(json["club"]),
        eventTitle: json["event_title"],
        description: json["description"],
        likes: json["likes"],
        startDate: DateTime.parse(json["start_date"]).toLocal(),
        endDate: DateTime.parse(json["end_date"]).toLocal(),
        image: json["image"],
        featureEvent: List<FeatureEvent>.from(
            json["feature_event"].map((x) => FeatureEvent.fromJson(x))),
        eventArtist: List<EventArtist>.from(
            json["event_artist"].map((x) => EventArtist.fromJson(x))),
        eventGallery: List<EventGallery>.from(
            json["event_gallery"].map((x) => EventGallery.fromJson(x))),
        eventSchedule: List<EventSchedule>.from(
            json["event_schedule"].map((x) => EventSchedule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "club": club.toJson(),
        "event_title": eventTitle,
        "description": description,
        "likes": likes,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "image": image,
        "feature_event":
            List<dynamic>.from(featureEvent.map((x) => x.toJson())),
        "event_artist": List<dynamic>.from(eventArtist.map((x) => x.toJson())),
        "event_gallery":
            List<dynamic>.from(eventGallery.map((x) => x.toJson())),
        "event_schedule":
            List<dynamic>.from(eventSchedule.map((x) => x.toJson())),
      };
}

class Club {
  Club({
    this.id,
    this.name,
    this.description,
    this.logo,
    this.street,
    this.city,
    this.state,
    this.country,
  });

  int id;
  String name;
  dynamic description;
  String logo;
  String street;
  String city;
  String state;
  String country;

  factory Club.fromJson(Map<String, dynamic> json) => Club(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        logo: json["logo"],
        street: json["street"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "logo": logo,
        "street": street,
        "city": city,
        "state": state,
        "country": country,
      };
}

class EventArtist {
  EventArtist({
    this.id,
    this.guestArtist,
    this.isMain,
    this.event,
  });

  int id;
  GuestArtist guestArtist;
  bool isMain;
  int event;

  factory EventArtist.fromJson(Map<String, dynamic> json) => EventArtist(
        id: json["id"],
        guestArtist: GuestArtist.fromJson(json["guest_artist"]),
        isMain: json["is_main"],
        event: json["event"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "guest_artist": guestArtist.toJson(),
        "is_main": isMain,
        "event": event,
      };
}

class GuestArtist {
  GuestArtist({
    this.id,
    this.name,
    this.primaryContact,
    this.secondaryContact,
    this.profileImage,
    this.cover,
    this.isAvailable,
    this.isPopularArtist,
  });

  int id;
  String name;
  String primaryContact;
  String secondaryContact;
  String profileImage;
  dynamic cover;
  bool isAvailable;
  bool isPopularArtist;

  factory GuestArtist.fromJson(Map<String, dynamic> json) => GuestArtist(
        id: json["id"],
        name: json["name"],
        primaryContact: json["primary_contact"],
        secondaryContact: json["secondary_contact"],
        profileImage: json["profile_image"],
        cover: json["cover"],
        isAvailable: json["is_available"],
        isPopularArtist: json["is_popular_artist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "primary_contact": primaryContact,
        "secondary_contact": secondaryContact,
        "profile_image": profileImage,
        "cover": cover,
        "is_available": isAvailable,
        "is_popular_artist": isPopularArtist,
      };
}

class EventGallery {
  EventGallery({
    this.id,
    this.event,
    this.galleryTitle,
    this.image,
    this.tags,
  });

  int id;
  String event;
  String galleryTitle;
  String image;
  String tags;

  factory EventGallery.fromJson(Map<String, dynamic> json) => EventGallery(
        id: json["id"],
        event: json["event"],
        galleryTitle: json["gallery_title"],
        image: json["image"],
        tags: json["tags"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "event": event,
        "gallery_title": galleryTitle,
        "image": image,
        "tags": tags,
      };
}

class EventSchedule {
  EventSchedule({
    this.id,
    this.title,
    this.startDate,
    this.endDate,
    this.isActive,
    this.eventSchedules,
  });

  int id;
  String title;
  DateTime startDate;
  DateTime endDate;
  bool isActive;
  int eventSchedules;

  factory EventSchedule.fromJson(Map<String, dynamic> json) => EventSchedule(
        id: json["id"],
        title: json["title"],
        startDate: DateTime.parse(json["start_date"]).toLocal(),
        endDate: DateTime.parse(json["end_date"]).toLocal(),
        isActive: json["is_active"],
        eventSchedules: json["event_schedules"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "is_active": isActive,
        "event_schedules": eventSchedules,
      };
}

class FeatureEvent {
  FeatureEvent({
    this.id,
    this.featuredTitle,
    this.description,
    this.startDate,
    this.endDate,
    this.event,
  });

  int id;
  String featuredTitle;
  String description;
  DateTime startDate;
  DateTime endDate;
  int event;

  factory FeatureEvent.fromJson(Map<String, dynamic> json) => FeatureEvent(
        id: json["id"],
        featuredTitle: json["featured_title"],
        description: json["description"],
        startDate: DateTime.parse(json["start_date"]).toLocal(),
        endDate: DateTime.parse(json["end_date"]).toLocal(),
        event: json["event"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "featured_title": featuredTitle,
        "description": description,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "event": event,
      };
}
