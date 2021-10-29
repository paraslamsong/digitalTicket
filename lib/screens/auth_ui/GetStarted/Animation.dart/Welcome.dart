import 'package:fahrenheit/screens/auth_ui/GetStarted/Animation.dart/LoginSignUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WelcomePart extends StatefulWidget {
  final GlobalKey<LoginSignUpState> loginKey;
  WelcomePart(this.loginKey, {Key key}) : super(key: key);
  @override
  WelcomePartState createState() => WelcomePartState();
}

class WelcomePartState extends State<WelcomePart> {
  bool show = true;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      child: AnimatedOpacity(
        opacity: show ? 1 : 0,
        duration: Duration(milliseconds: 200),
        child: TextButton(
          onPressed: () {
            setState(() {
              show = false;
            });
            widget.loginKey.currentState.startAnimation();
          },
          child: Text(
            "Get Started",
            style: TextStyle(color: Colors.white, fontSize: 14.0),
          ),
        ),
      ),
    );
  }
}
