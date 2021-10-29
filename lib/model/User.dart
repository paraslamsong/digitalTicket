import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Session {
  factory Session() {}
}

class User {
  String _access, _refresh;
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

  Future<bool> isSessionAvalable() async {
    try {
      await loadToken();
      if (this._access == null || this._refresh == null) return false;
      return true;
    } catch (e) {
      return false;
    }
  }
}
