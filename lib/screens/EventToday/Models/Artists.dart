import 'package:dio/dio.dart';
import 'package:fahrenheit/api/HTTP.dart';

class Artist {
  int id;
  String name, primaryContact, secondaryContact, profileImage, coverImage;
  bool isAvailable, isPopularArtist;
  fromJson(json) {
    this.id = json['id'] ?? 0;
    this.name = json['name'] ?? "";
    this.primaryContact = json['primary_contact'] ?? "";
    this.secondaryContact = json['secondary_contact'] ?? "";
    this.profileImage = json['profile_image'] ?? "";
    this.coverImage = json['cover'] ?? "";
    this.isAvailable = json['is_available'] ?? false;
    this.isPopularArtist = json['is_popular_artist'] ?? false;
  }
}

class Artists {
  List<Artist> artists = [];
  fetchData() async {
    Response response = await HTTP().get(path: "popular-artists");
    if (response.statusCode == 200) {
      var result = response.data;
      this.artists = [];
      result.forEach((element) {
        Artist artist = Artist();
        artist.fromJson(element);
        artists.add(artist);
      });
    }
    return this;
  }
}
