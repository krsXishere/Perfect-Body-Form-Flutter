import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:perfect_body_form/common/constant.dart';
import 'package:perfect_body_form/models/detail_achievement_model.dart';

class AchievementService {
  final storage = FlutterSecureStorage(aOptions: getAndroidOptions());

  Future<double?> getAchievement() async {
    String apiURL = "${baseAPIURL()}/achievement";
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
        // print("${jsonObject['data']}");

        return double.parse(jsonObject['data'].toString());
      } else {
        return null;
      }
    } catch (e) {
      // print("$e");
      throw Exception("Gagal memuat daftar latihan $e");
    }
  }

  Future<DetailAchievementModel> createAchievement(String exerciseId) async {
    String apiURL = "${baseAPIURL()}/create-achievement";
    String? token = await storage.read(key: "token");

    try {
      var response = await post(
        Uri.parse(apiURL),
        headers: header(
          true,
          token: token,
        ),
        body: {
          "exercise_id": exerciseId,
        }
      );

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);

        return DetailAchievementModel.fromJson(jsonObject);
      } else {
        var jsonObject = jsonDecode(response.body);

        return DetailAchievementModel.fromJson(jsonObject);
      }
    } catch (e) {
      // print("$e");
      throw Exception("Gagal memuat daftar latihan $e");
    }
  }
}
