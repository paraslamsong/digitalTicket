import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HTTP {
  HTTP._privateConstructor();

  static final HTTP _instance = HTTP._privateConstructor();

  factory HTTP() {
    return _instance;
  }

  String _apiBase = "https://alishmanandhar.com.np/api/";

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
    print(body);
    try {
      response = await Dio().post(this._apiBase + path, data: body);
    } on DioError catch (e) {
      response = e.response;
    }
    return response;
  }

  getImageBase() {
    return this._apiBase.replaceAll("/api/", "");
  }
}
