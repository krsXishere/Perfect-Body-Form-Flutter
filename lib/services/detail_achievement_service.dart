import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:perfect_body_form/common/constant.dart';
import 'package:perfect_body_form/models/detail_achievement_model.dart';

class DetailAchievementService {
  final storage = FlutterSecureStorage(aOptions: getAndroidOptions());

  Future<List<DetailAchievementModel>> getDetailAchievements() async {
    String apiURL = "${baseAPIURL()}/detail-achievement";
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
        final detailAchievement = jsonDecode(response.body)['data'] as List;
        final detailAchievements = detailAchievement.map((object) {
          return DetailAchievementModel(
            id: object['id'],
            achievementId: object['achievement_id'],
            exerciseId: object['exercise_id'],
            status: object['status'],
          );
        }).toList();

        return detailAchievements;
      } else {
        return [];
      }
    } catch (e) {
      // print("$e");
      throw Exception("Gagal memuat daftar latihan $e");
    }
  }
}
