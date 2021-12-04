import 'package:dio/dio.dart';
import 'package:fahrenheit/api/HTTP.dart';
import 'package:fahrenheit/model/User.dart';
import 'package:fahrenheit/screens/EventToday/EventsTodayPage.dart';
import 'package:fahrenheit/screens/utils/loadingOverlay.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp {
  String firstName, lastName, email, password, gender = "";
  bool acceptTerms = false;

  setUserDetails(
      {String firstName,
      String lastName,
      String email,
      String password,
      String gender,
      bool acceptTerms}) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.password = password;
    this.gender = gender;
    this.acceptTerms = acceptTerms;
  }

  void sendOtp() async {
    Response response =
        await HTTP().post(path: "send-otp/", body: {"email": this.email});
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "OTP sent");
    }
  }

  Future<void> createUser(BuildContext context, {String otp}) async {
    OverlayLoader(context).show();
    try {
      Response response = await HTTP().post(path: "create-user/", body: {
        "email": this.email,
        "password": this.password,
        "gender": this.gender,
        "otp": int.parse(otp),
        "firstName": this.firstName,
      });
      if (response != null) {
        OverlayLoader(context).hide();
        if (response.statusCode == 200) {
          var json = response.data;
          User().setTokens(access: json['access'], refresh: json['refresh']);
          User().saveToken();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => EventsTodayPage()));
        } else {
          Fluttertoast.showToast(msg: response.data['message']);
        }
      }

      print(response.statusCode);
      print(response.data);
    } catch (e) {
      OverlayLoader(context).hide();
    }
  }
}
