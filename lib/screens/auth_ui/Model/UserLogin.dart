import 'package:dio/dio.dart';
import 'package:fahrenheit/api/HTTP.dart';
import 'package:fahrenheit/bloc/BlocState.dart';
import 'package:fahrenheit/model/User.dart';
import 'package:fahrenheit/screens/EventToday/EventsTodayPage.dart';
import 'package:fahrenheit/screens/utils/loadingOverlay.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/src/provider.dart';

class UserLogin {
  String email, _password;

  UserLogin(this.email, this._password);
  doLogin(BuildContext context) async {
    OverlayLoader(context).show();
    Map<String, dynamic> body = {
      "email": this.email,
      "password": this._password
    };
    Response response = await HTTP().post(path: 'token/', body: body);
    var result = response.data;
    if (response.statusCode == 200) {
      User().setTokens(access: result['access'], refresh: result['refresh']);
      User().saveToken();
      print(User().getAcess());
      Fluttertoast.showToast(msg: "Logged in", backgroundColor: Colors.green);
      OverlayLoader(context).hide();

      context.read<SessionCubit>().loggedIn();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => EventsTodayPage()));
    } else {
      Fluttertoast.showToast(
          msg: result['detail'], backgroundColor: Colors.red);
      OverlayLoader(context).hide();
    }
  }
}
