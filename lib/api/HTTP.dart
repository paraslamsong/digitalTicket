import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fahrenheit/model/User.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HTTP {
  HTTP._privateConstructor();

  static final HTTP _instance = HTTP._privateConstructor();

  factory HTTP() {
    return _instance;
  }

  String _apiBase = "https://api.meroticketapp.com/api/";
  // "http://192.168.1.71:2000/api/"; //"https://api.meroticketapp.com/api/";

  Future<Response<dynamic>> refreshToken({onCallback}) async {
    Response response;
    String path = "token/refresh/";
    print(this._apiBase + path);
    response = await Dio()
        .post(this._apiBase + path, data: {"refresh": User().getRefresh()});
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
    print(this._apiBase + path);
    print(User().getAcess());
    try {
      if (!useToken)
        response = await Dio().get(this._apiBase + path);
      else
        response = await Dio().get(
          this._apiBase + path,
          options: Options(
            headers: {
              "Authorization": User().getAcess(),
            },
          ),
        );
    } on DioError catch (e) {
      response = e.response;
      if (response.statusCode == null) {
        response = await get(context: context, path: path, useToken: useToken);
      } else if (response.statusCode == 401) {
        response = await refreshToken(onCallback: () async {
          return await this
              .get(path: path, context: context, useToken: useToken);
        });
      }
    }
    return response;
  }

  Future<Response> post(
      {BuildContext context,
      String path,
      Map<String, dynamic> body,
      bool useToken = false,
      bool isLogin = false}) async {
    Response response;
    print(path);
    print(
      this._apiBase + path,
    );
    print(body);

    try {
      if (!useToken)
        response = await Dio().post(this._apiBase + path, data: body);
      else {
        response = await Dio().post(
          this._apiBase + path,
          data: body,
          options: Options(
            headers: {
              "Authorization": User().getAcess(),
            },
          ),
        );
      }
    } on DioError catch (e) {
      response = e.response;

      if (response.statusCode == null) {
        response = await post(
            context: context,
            path: path,
            body: body,
            useToken: useToken,
            isLogin: isLogin);
      } else if (!isLogin && response.statusCode == 401) {
        response = await refreshToken(onCallback: () async {
          return await this.post(
              path: path, context: context, body: body, useToken: useToken);
        });
      }
    }
    return response;
  }

  Future<Response> put({
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
      if (!useToken)
        response = await Dio().put(this._apiBase + path, data: body);
      else {
        response = await Dio().put(
          this._apiBase + path,
          data: body,
          options: Options(
            headers: {
              "Authorization": User().getAcess(),
            },
          ),
        );
      }
    } on DioError catch (e) {
      response = e.response;
      if (response.statusCode == null) {
        response = await put(
            context: context, path: path, body: body, useToken: useToken);
      } else if (response.statusCode == 401) {
        response = await refreshToken(onCallback: () async {
          return await this.put(
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
