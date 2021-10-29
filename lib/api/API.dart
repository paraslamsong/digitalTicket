import 'package:flutter/material.dart';
import 'package:http/http.dart';

abstract class API {
  Future<Response> getApi({BuildContext context, @required String endpoint});
  Future<Response> postApi(
      {BuildContext context,
      @required String endpoint,
      @required Map<String, dynamic> body});
}
