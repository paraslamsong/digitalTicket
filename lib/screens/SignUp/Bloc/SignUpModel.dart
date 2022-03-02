import 'package:dio/dio.dart';
import 'package:fahrenheit/api/HTTP.dart';
import 'package:fahrenheit/bloc/BlocState.dart';
import 'package:fahrenheit/model/User.dart';
import 'package:fahrenheit/screens/EventToday/EventsTodayPage.dart';
import 'package:fahrenheit/screens/MainScreen/MainScreen.dart';
import 'package:fahrenheit/screens/utils/loadingOverlay.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/src/provider.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
}

class SignUp {
  String firstName, phone, email, password, dob, location, gender = "";
  bool acceptTerms = false;

  setUserDetails(
      {String firstName,
      String phone,
      String email,
      String password,
      String gender,
      String dob,
      String location,
      bool acceptTerms}) {
    this.firstName = firstName;
    this.phone = phone;
    this.email = email;
    this.password = password;
    this.gender = gender;
    this.dob = dob;
    this.location = location;
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
      print({
        "email": this.email,
        "password": this.password,
        "gender": this.gender,
        "otp": int.parse(otp),
        "firstName": this.firstName,
        "dob": this.dob,
        "phone": this.phone,
        "location": this.location,
      });
      Response response = await HTTP().post(path: "create-user/", body: {
        "email": this.email,
        "password": this.password,
        "gender": this.gender.toUpperCase(),
        "otp": int.parse(otp),
        "firstName": this.firstName,
        "dob": this.dob,
        "phone": this.phone,
        "location": this.location,
      });
      if (response != null) {
        OverlayLoader(context).hide();
        print(response.data);
        print(response.statusCode);
        if (response.statusCode == 200) {
          var json = response.data;
          User().setTokens(access: json['access'], refresh: json['refresh']);
          User().saveToken();

          context.read<SessionCubit>().loggedIn();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
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
