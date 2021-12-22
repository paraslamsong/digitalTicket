import 'dart:ui';
import 'package:fahrenheit/model/User.dart';
import 'package:fahrenheit/screens/EventToday/EventsTodayPage.dart';
import 'package:fahrenheit/screens/auth_ui/GetStarted/Animation.dart/LoginSignUp.dart';
import 'package:fahrenheit/screens/auth_ui/GetStarted/Animation.dart/Welcome.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class GetStartedPage extends StatefulWidget {
  @override
  _LogInSignUpPageState createState() => _LogInSignUpPageState();
}

class _LogInSignUpPageState extends State<GetStartedPage> {
  bool _move = false;
  bool _noLogin = false;
  GlobalKey<LoginSignUpState> _loginKey = GlobalKey();
  GlobalKey<WelcomePartState> _welcomeKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        _move = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 2000), () async {
      if (await User().isSessionAvalable(context)) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => EventsTodayPage()));
      } else {
        setState(() {
          _noLogin = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black54,
          // image: DecorationImage(
          //   image: AssetImage("images/background_image.jpeg"),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(alignment: Alignment.topCenter, children: [
                AnimatedPositioned(
                  top: _move ? 150 : 0,
                  curve: Curves.easeInOutBack,
                  duration: Duration(milliseconds: 700),
                  child: Hero(
                    tag: "Logo",
                    child: SimpleShadow(
                      child: Image.asset('assets/icons/logo.png', width: 220),
                      opacity: 1,
                      color: Colors.white,
                      offset: Offset(0, 0),
                      sigma: 1,
                    ),
                  ),
                ),
              ]),
            ),
            Expanded(
              child: AnimatedOpacity(
                opacity: _noLogin ? 1 : 0,
                duration: Duration(milliseconds: 200),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 6.6),
                    Center(
                      child: Text(
                        "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Center(
                      child: Text(
                        "Welcome to Mero Ticket App",
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            WelcomePart(_loginKey, key: _welcomeKey),
                            LoginSignUp(key: _loginKey),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
