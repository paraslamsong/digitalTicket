import 'dart:async';

import 'package:fahrenheit/bloc/splash_bloc.dart';
import 'package:fahrenheit/screens/Dashboard/Dashboard.dart';
import 'package:fahrenheit/screens/EventToday/EventsTodayPage.dart';
import 'package:fahrenheit/screens/auth_ui/log_in_screen.dart';
import 'package:fahrenheit/screens/auth_ui/GetStarted/GetStarted.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashBloc _splashBloc = SplashBloc(null);
  String token;
  bool _isAppOpened = false;

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
        return EventsTodayPage();
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
      /*  body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
        child: BlocProvider(
          create: (_) => _splashBloc,
          child: BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              if (state is SplashLoaded) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => DashboardPage(),
                  ),
                );
              }
            },
            child: _buildSplashWidget(),
          ),
        ),
      ),*/
    );
  }

  Widget _buildSplashWidget() {
    return Center(
      child: Text(
        "Logo Splash",
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );
  }

  _getIsAppAlreadyLoaded() async {
    String userToken = await LocalUserProvider.getToken();
    bool _isAppOpened = await LocalUserProvider.getIsAppAlreadyOpened();
    if (userToken != null) {
      setState(() {
        this.token = userToken;
      });
    }
    /*if (_isAppOpened != null) {
      setState(() {
        this._isAppOpened = _isAppOpened;
      });
    }*/
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
