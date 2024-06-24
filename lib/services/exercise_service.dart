import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:perfect_body_form/common/constant.dart';
import 'package:perfect_body_form/models/exercise_model.dart';

class ExerciseService {
  final storage = FlutterSecureStorage(aOptions: getAndroidOptions());

  Future<List<ExerciseModel>> getExercises() async {
    String apiURL = "${baseAPIURL()}/exercises";
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
        final exercise = jsonDecode(response.body)['data'] as List;
        // print("$exercise");
        final exercises = exercise.map((object) {
          return ExerciseModel(
            id: object['id'],
            setTypeId: object['set_type_id'],
            bodyMassStandartId: object['body_mass_standart_id'],
            exerciseName: object['exercise_name'],
            time: object['time'],
            instructions: object['instructions'],
            setType: object['set_type']['set_type'],
            bodyMassStandart: object['body_mass_standard']['standard'],
            status: object['status'],
            message: object['message'],
          );
        }).toList();

        return exercises;
      } else {
        // var jsonObject = jsonDecode(response.body);

        return [];
      }
    } catch (e) {
      // print("$e");
      throw Exception("Gagal memuat daftar latihan $e");
    }
  }
}
