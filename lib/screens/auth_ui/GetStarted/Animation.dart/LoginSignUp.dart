import 'package:fahrenheit/screens/EventToday/EventsTodayPage.dart';
import 'package:fahrenheit/screens/MainScreen/MainScreen.dart';
import 'package:fahrenheit/screens/SignUp/TabView.dart';
import 'package:fahrenheit/screens/auth_ui/GetStarted/Widgets/SocialLoginButton.dart';
import 'package:fahrenheit/screens/auth_ui/Model/SocialLogin.dart';
import 'package:fahrenheit/screens/auth_ui/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:khalti/khalti.dart';

class LoginSignUp extends StatefulWidget {
  LoginSignUp({Key key}) : super(key: key);
  @override
  LoginSignUpState createState() => LoginSignUpState();
}

class LoginSignUpState extends State<LoginSignUp>
    with TickerProviderStateMixin {
  bool _visible = false;

  AnimationController controller;
  Animation<double> opacity;
  Animation<Offset> position;
  final alphaTween = new Tween(begin: 0.0, end: 0.0);
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    opacity = alphaTween.animate(controller);
  }

  void startAnimation() {
    final alphaTween = new Tween(begin: 0.0, end: 1.0);
    setState(() {
      _visible = true;
    });
    opacity = alphaTween.animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: _visible ? 0 : 100,
      duration: Duration(milliseconds: 800),
      child: FadeTransition(
        opacity: opacity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: "LoginBtn",
                  child: TextButton(
                    style: ButtonStyle(),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return LogInScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "LOG IN",
                      style: TextStyle(color: Colors.white, fontSize: 13.0),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                TextButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return TabView();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(color: Colors.white, fontSize: 13.0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Visibility(
              visible: Platform.isAndroid,
              child: Center(
                child: SocialLoginButton.googleButton(context),
              ),
            ),
            Visibility(
              visible: Platform.isIOS,
              child: Row(
                children: [
                  SizedBox(width: 10),
                  SocialLoginButton.googleButton(context),
                  SizedBox(width: 10),
                  SocialLoginButton.appleButton(context),
                  SizedBox(width: 10),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MainScreen()));
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent)),
              child: Text("Skip Now"),
            ),
          ],
        ),
      ),
    );
  }
}
