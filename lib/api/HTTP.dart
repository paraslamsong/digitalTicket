import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fahrenheit/model/User.dart';
import 'package:flutter/material.dart';

class HTTP {
  HTTP._privateConstructor();

  static final HTTP _instance = HTTP._privateConstructor();

  factory HTTP() {
    return _instance;
  }

  String _apiBase = "https://alishmanandhar.com.np/api/";

  Future<Response<dynamic>> refreshToken({onCallback}) async {
    Response response;
    String path = "accounts/refresh/";
    print(this._apiBase + path);
    response = await Dio().post(this._apiBase + path,
        data: {"refreshtoken": User().getRefresh()});
    if (response.statusCode == 200) {
      await User().setTokens(
          refresh: User().getRefresh(), access: response.data['access']);
      User().saveToken();
    }
    final responseCompleter = new Completer<Response>();
    responseCompleter.complete(onCallback());
    return responseCompleter.future;
  }

  Future<Response> get({
    BuildContext context,
    String path,
    bool useToken = false,
  }) async {
    Response response;
    try {
      response = await Dio().get(this._apiBase + path);
    } on DioError catch (e) {
      response = e.response;

      if (response.statusCode == 403) {
        response = await refreshToken(onCallback: () async {
          return await this
              .get(path: path, context: context, useToken: useToken);
        });
      }
    }
    return response;
  }

  Future<Response> post({
    BuildContext context,
    String path,
    Map<String, dynamic> body,
    bool useToken = false,
  }) async {
    Response response;
    print(path);
    print(
      this._apiBase + path,
    );
    try {
      response = await Dio().post(this._apiBase + path, data: body);
    } on DioError catch (e) {
      response = e.response;
      if (response.statusCode == 403) {
        response = await refreshToken(onCallback: () async {
          return await this.post(
              path: path, context: context, body: body, useToken: useToken);
        });
      }
    }
    return response;
  }

  getImageBase() {
    return this._apiBase.replaceAll("/api/", "");
  }
}
