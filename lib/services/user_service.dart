import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:perfect_body_form/common/constant.dart';
import 'package:perfect_body_form/models/user_model.dart';

class UserService {
  final storage = FlutterSecureStorage(aOptions: getAndroidOptions());

  Future<UserModel> getUserProfile() async {
    String apiURL = "${baseAPIURL()}/user";
    String? token = await storage.read(key: "token");

    try {
      var response = await get(
        Uri.parse(apiURL),
        headers: header(
          true,
          token: token,
        ),
      );

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);

        return UserModel.fromJson(jsonObject);
      } else {
        var jsonObject = jsonDecode(response.body);

        return UserModel.fromJson(jsonObject);
      }
    } catch (e) {
      throw Exception("Gagal get data user. Error: $e");
    }
  }

  Future<UserModel> calculateBMI(String height, weight) async {
    String apiURL = "${baseAPIURL()}/bmi";
    String? token = await storage.read(key: "token");

    try {
      var response = await post(
        Uri.parse(apiURL),
        headers: header(
          true,
          token: token,
        ),
        body: {
          "height": height,
          "weight": weight,
        },
      );

      if(response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);

        return UserModel.fromJson(jsonObject);
      } else {
        var jsonObject = jsonDecode(response.body);

        return UserModel.fromJson(jsonObject);
      }
    } catch (e) {
      // print("$e");
      throw Exception(e);
    }
  }
}
