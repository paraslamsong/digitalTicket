import 'dart:async';
import 'package:fahrenheit/screens/EventToday/EventsTodayPage.dart';
import 'package:fahrenheit/screens/MainScreen/MainScreen.dart';
import 'package:fahrenheit/screens/auth_ui/GetStarted/GetStarted.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String token;

  @override
  void initState() {
    //_splashBloc.add(SetSplash());
    super.initState();
    _getIsAppAlreadyLoaded();
    startTime();
  }

  void navigationPage() {
    if (token == null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return GetStartedPage();
      }));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return MainScreen();
      }));
    }
  }

  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Image.asset(
            "images/background_image.jpg",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Image.asset("images/logo.png"),
        ],
      ),
    );
  }

  _getIsAppAlreadyLoaded() async {
    String userToken = await LocalUserProvider.getToken();
    if (userToken != null) {
      setState(() {
        this.token = userToken;
      });
    }
  }
}

class LocalUserProvider {
  static Future<String> getSavedUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("user");
  }

  static Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("token");
  }

  static Future<bool> getIsAppAlreadyOpened() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool("isAppOpened");
  }
}
