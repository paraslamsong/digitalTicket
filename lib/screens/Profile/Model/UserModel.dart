import 'package:dio/dio.dart';
import 'package:fahrenheit/api/HTTP.dart';
import 'package:fahrenheit/model/User.dart';

class UserModel {
  String firstName, email, gender;
  Future<UserModel> fetchData() async {
    Response response =
        await HTTP().get(path: "user-profile/${User().getAcess()}/");
    if (response.statusCode == 200) {
      var result = response.data;
      this.firstName = result['full_name'] ?? "";
      this.email = result['email'] ?? "";
      this.gender = result['gender'] ?? "";
    }
    return this;
  }
}
