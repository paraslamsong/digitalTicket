import 'dart:convert';

PopularArtistsModel popularArtistsModelFromJson(String str) =>
    PopularArtistsModel.fromJson(json.decode(str));

String popularArtistsModelToJson(PopularArtistsModel data) =>
    json.encode(data.toJson());

class PopularArtistsModel {
  PopularArtistsModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory PopularArtistsModel.fromJson(Map<String, dynamic> json) =>
      PopularArtistsModel(
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
  String cover;
  bool isAvailable;
  bool isPopularArtist;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
