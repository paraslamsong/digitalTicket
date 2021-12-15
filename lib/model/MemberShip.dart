// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<MemberShip> memberShipFromJson(String str) =>
    List<MemberShip>.from(json.decode(str).map((x) => MemberShip.fromJson(x)));

String memberShipToJson(List<MemberShip> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberShip {
  MemberShip({
    this.id,
    this.title,
    this.description,
    this.price,
    this.startDate,
    this.endDate,
  });

  int id;
  String title;
  String description;
  String price;
  DateTime startDate;
  DateTime endDate;

  factory MemberShip.fromJson(Map<String, dynamic> json) => MemberShip(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        startDate: DateTime.parse(json["start_date"]).toLocal(),
        endDate: DateTime.parse(json["end_date"]).toLocal(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
      };
}
