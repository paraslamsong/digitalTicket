import 'package:dio/dio.dart';
import 'package:fahrenheit/api/HTTP.dart';
import 'package:fahrenheit/model/User.dart';
import 'package:flutter/material.dart';

class UserModel {
  int id;
  String firstName, email, gender, dob, phone, location;
  Future<UserModel> fetchData() async {
    Response response = await HTTP().get(path: "user-profile/", useToken: true);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var result = response.data;
      print(result);
      this.id = result['id'];
      this.firstName = result['full_name'] ?? "";
      this.email = result['email'] ?? "";
      this.phone = result['phone'];
      this.dob = result['dob'].toString();
      this.gender = result['gender'] ?? "";
      this.location = result['location'];
    }
    return this;
  }

  Future<UserModel> saveChanges(
    BuildContext context, {
    int id,
    String fullName,
    String email,
    String phone,
    String location,
    String dob,
    String gender,
  }) async {
    Map<String, dynamic> body = {
      "id": this.id,
      "email": email,
      "full_name": fullName,
      "phone": phone,
      "location": location,
      "gender": gender,
      "dob": dob
    };
    print(body);
    Response response = await HTTP()
        .put(path: "update-user-profile/", body: body, useToken: true);
    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode <= 209) {
      final snackBar = SnackBar(
        content: Text('Profile updated!'),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('Unable to save changes!'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return this;
  }
}
