import 'dart:convert';

import 'package:fahrenheit/api/API.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class APIService extends API {
  String _apiUrl = "https://api.meroticketapp.com/";

  Future<Response> _getNoToken(String url) async {
    Response response = await get(Uri(path: url));
    return response;
  }

  @override
  Future<Response> getApi({BuildContext context, String endpoint}) async {
    assert(endpoint != null);
    Response response;
    if (context != null) {
      response = await _getNoToken(_apiUrl + endpoint);
    } else {
      response = await _getNoToken(_apiUrl + endpoint);
    }
    return response;
  }

  Future<Response> _postNoToken(String url, Map<String, dynamic> body) async {
    Response response =
        await post(Uri(path: url), body: jsonEncode(body), headers: {
      "Content-Type": "application/json",
    });
    return response;
  }

  @override
  Future<Response> postApi(
      {BuildContext context,
      String endpoint,
      Map<String, dynamic> body}) async {
    Response response;
    if (context != null) {
      response = await _getNoToken(_apiUrl + endpoint);
    } else {
      response = await _postNoToken(_apiUrl + endpoint, body);
    }
    return response;
  }
}
