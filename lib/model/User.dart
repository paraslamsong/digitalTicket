import 'dart:convert';
import 'package:fahrenheit/bloc/BlocState.dart';
import 'package:fahrenheit/screens/auth_ui/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Session {}

class User {
  String _access = "", _refresh = "";
  User._privateConstructor();
  static final User _instance = User._privateConstructor();
  factory User() {
    return _instance;
  }

  setTokens({String access, String refresh}) {
    this._access = access;
    this._refresh = refresh;
  }

  saveToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
        "@session",
        jsonEncode({
          "access": this._access,
          "refresh": this._refresh,
        }));

    print("saved");
  }

  loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getString("@session");
    Map<String, dynamic> session = jsonDecode(data);
    this.setTokens(access: session['access'], refresh: session['refresh']);
  }

  String getAcess() {
    return this._access;
  }

  String getRefresh() {
    return this._refresh;
  }

  Future<bool> isSessionAvalable(BuildContext context) async {
    try {
      await loadToken();
      if (this._access == null || this._refresh == null) return false;
      context.read<SessionCubit>().loggedIn();
      return true;
    } catch (e) {
      return false;
    }
  }

  logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    this._refresh = "";
    this._access = "";

    context.read<SessionCubit>().loggOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LogInScreen()),
    );
  }
}
