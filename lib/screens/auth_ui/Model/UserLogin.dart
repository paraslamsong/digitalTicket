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
    try {
      Response response = await Dio()
          .post("https://api.meroticketapp.com/api/token/", data: body);
      var result = response.data;
      if (response.statusCode == 200) {
        print(result);
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
      }
    } on DioError catch (e) {
      print(e.response.data);
      Fluttertoast.showToast(
          msg: e.response.data['detail'], backgroundColor: Colors.red);
      OverlayLoader(context).hide();
    }
  }
}
