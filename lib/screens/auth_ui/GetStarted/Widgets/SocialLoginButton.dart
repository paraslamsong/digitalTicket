import 'package:fahrenheit/screens/auth_ui/Model/SocialLogin.dart';
import 'package:flutter/material.dart';

class SocialLoginButton {
  static Widget googleButton(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await SocialLogin.googlelogin(context);
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 15, horizontal: 15)),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        elevation: MaterialStateProperty.all(3),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: Row(
        children: [
          Image.asset("assets/icons/googlelogin.png", width: 20),
          SizedBox(width: 10),
          Text(
            "Sign in with Google",
            style: TextStyle(color: Colors.black, fontSize: 10.0),
          ),
        ],
      ),
    );
  }

  static Widget appleButton(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await SocialLogin.applelogin(context);
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 15, horizontal: 15)),
        backgroundColor: MaterialStateProperty.all(Color(0xff050609)),
        elevation: MaterialStateProperty.all(3),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: Row(
        children: [
          Image.asset("assets/icons/applelogin.png", width: 20),
          SizedBox(width: 10),
          Text(
            "Sign in with Apple",
            style: TextStyle(color: Colors.white, fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}
