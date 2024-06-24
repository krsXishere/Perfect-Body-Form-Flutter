import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:perfect_body_form/common/constant.dart';
import 'package:perfect_body_form/models/auth_model.dart';

class AuthService {
  Future<AuthModel> signUp(
    String name,
    String email,
    String password,
    String genderId,
  ) async {
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
    String apiURL = "${baseAPIURL()}/sign-up";

    try {
      var response = await post(
        Uri.parse(apiURL),
        headers: header(false),
        body: {
          'name': name,
          'email': email,
          'password': password,
          'gender_id': genderId,
        },
      );

      // print("Euy: ${jsonDecode(response.body)}");

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        await storage.write(key: 'token', value: jsonObject['data']['token']);
        // print("Response euy:" + jsonObject);

        return AuthModel.fromJson(jsonObject);
      } else {
        var jsonObject = jsonDecode(response.body);
        // print("Response euy:" + jsonObject);

        return AuthModel.fromJson(jsonObject);
      }
    } catch (e) {
      // print("Cek errorna " + e.toString());
      debugPrintStack();
      throw Exception("Sign Up Gagal. Error: $e");
    }
  }

  Future<AuthModel> signIn(
    String email,
    String password,
  ) async {
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
    String apiURL = "${baseAPIURL()}/sign-in";

    try {
      var response = await post(
        Uri.parse(apiURL),
        headers: header(false),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        await storage.write(key: 'token', value: jsonObject['data']['token']);

        return AuthModel.fromJson(jsonObject);
      } else {
        var jsonObject = jsonDecode(response.body);

        return AuthModel.fromJson(jsonObject);
      }
    } catch (e) {
      // print("$e");
      throw Exception("Sign Up Gagal. Error: $e");
    }
  }

  Future<bool> signOut() async {
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
    String apiURL = "${baseAPIURL()}/sign-out";
    String? token = await storage.read(key: "token");

    try {
      var response = await post(
        Uri.parse(apiURL),
        headers: header(
          true,
          token: token,
        ),
      );

      // print("Euy: ${jsonDecode(response.body)}");

      if (response.statusCode == 200) {
        // var jsonObject = jsonDecode(response.body);
        // print("Response euy:" + jsonObject);
        storage.delete(key: "token");

        return true;
      } else {
        // var jsonObject = jsonDecode(response.body);
        // print("Response euy:" + jsonObject);

        return false;
      }
    } catch (e) {
      // print("Cek errorna $e");
      throw Exception("Sign Out Gagal. Error: $e");
    }
  }
}
