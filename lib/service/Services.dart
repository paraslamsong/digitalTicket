import 'dart:convert';
import 'dart:io';
import 'package:fahrenheit/api/ApiList.dart';
import 'package:fahrenheit/model/AllEventsModel.dart';
import 'package:fahrenheit/model/EventDetailsModel.dart';
import 'package:fahrenheit/model/EventsTodayModel.dart';
import 'package:fahrenheit/model/PopularArtistsModel.dart';
import 'package:fahrenheit/screens/splash_screen.dart';
import 'package:http/http.dart' as http;

//Custom Package
import 'package:fahrenheit/model/MemberShip.dart';
import 'package:fahrenheit/model/FeaturedEventsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services {
  static Future<List<MemberShip>> getMemberShip() async {
    List<MemberShip> memberShip;
    try {
      final response = await http.get(ApiList.MEMBERSHIP);
      if (response.statusCode == 200) {
        print("MemberShip Response");
        // print(response.body);
        memberShip = memberShipFromJson(response.body);
        return memberShip;
      } else if (response.statusCode == 500) {
        print(response.body);
        print("500 Error");
        return List<MemberShip>();
      } else {
        print(response.body);
        print("Something went wrong!");
        return List<MemberShip>();
      }
    } catch (e) {
      print("Catch:  " + e.toString());
      return List<MemberShip>();
    }
  }

  static Future<EventsTodayModel> getEventsToday() async {
    EventsTodayModel eventsTodayModel;
    try {
      final response = await http.get(ApiList.API + "today-event");
      if (response.statusCode == 200) {
        print("EventsToday Response");
        print(response.body);
        eventsTodayModel = eventsTodayModelFromJson(response.body);
        return eventsTodayModel;
      } else if (response.statusCode == 500) {
        print(response.body);
        print("500 Error");
        return EventsTodayModel();
      } else {
        print(response.body);
        print("Something went wrong!");
        return EventsTodayModel();
      }
    } catch (e) {
      print("Catch:  " + e.toString());
      return EventsTodayModel();
    }
  }

  static Future<FeaturedEventsModel> getFeaturedEvents() async {
    FeaturedEventsModel featuredEventsModel;
    try {
      final response = await http.get(ApiList.API + "featured-events");
      if (response.statusCode == 200) {
        print("Featured Response");
        // print(response.body);
        featuredEventsModel = featuredEventsModelFromJson(response.body);
        return featuredEventsModel;
      } else if (response.statusCode == 500) {
        print(response.body);
        print("500 Error");
        return FeaturedEventsModel();
      } else {
        print(response.body);
        print("Something went wrong!");
        return FeaturedEventsModel();
      }
    } catch (e) {
      print("Catch:  " + e.toString());
      return FeaturedEventsModel();
    }
  }

  static Future<PopularArtistsModel> getPopularArtists() async {
    PopularArtistsModel popularArtistsModel;
    try {
      final response = await http.get(ApiList.API + "popular-artists");
      if (response.statusCode == 200) {
        print("PopularArtistsModel Response");
        // print(response.body);
        popularArtistsModel = popularArtistsModelFromJson(response.body);
        return popularArtistsModel;
      } else if (response.statusCode == 500) {
        print(response.body);
        print("500 Error");
        return PopularArtistsModel();
      } else {
        print(response.body);
        print("Something went wrong!");
        return PopularArtistsModel();
      }
    } catch (e) {
      print("Catch:  " + e.toString());
      return PopularArtistsModel();
    }
  }

  static Future<AllEventsModel> getAllEvents() async {
    AllEventsModel allEventsModel;
    try {
      final response = await http.get(ApiList.API + "events");
      if (response.statusCode == 200) {
        print("AllEventsModel Response");
        // print(response.body);
        allEventsModel = allEventsModelFromJson(response.body);
        return allEventsModel;
      } else if (response.statusCode == 500) {
        print(response.body);
        print("500 Error");
        return AllEventsModel();
      } else {
        print(response.body);
        print("Something went wrong!");
        return AllEventsModel();
      }
    } catch (e) {
      print("Catch:  " + e.toString());
      return AllEventsModel();
    }
  }

  static Future<EventDetailsModel> getEventDetails() async {
    EventDetailsModel eventDetailsModel;
    String userToken = await LocalUserProvider.getToken();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int eventTodayId = sharedPreferences.getInt("eventTodayId");
    print("EventTodayId: " + "$eventTodayId");
    try {
      final response = await http.get(ApiList.API + "event/$eventTodayId",
          headers: {HttpHeaders.authorizationHeader: "JWT $userToken"});
      if (response.statusCode == 200) {
        print("EventDetailsModel Response");
        print(response.body);
        eventDetailsModel = eventDetailsModelFromJson(response.body);
        print(eventDetailsModel.data.eventTitle);

        return eventDetailsModel;
      } else if (response.statusCode == 500) {
        print(response.body);
        print("500 Error");
        return EventDetailsModel();
      } else {
        print(response.body);
        print("Something went wrong!");
        return EventDetailsModel();
      }
    } catch (e) {
      print("Catch:  " + e.toString());
      return EventDetailsModel();
    }
  }
}
