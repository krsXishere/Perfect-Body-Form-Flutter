import 'package:flutter/material.dart';
import 'package:perfect_body_form/models/user_model.dart';
import 'package:perfect_body_form/services/user_service.dart';

class UserProvider with ChangeNotifier {
  final _userService = UserService();
  UserModel? _userModel;
  UserModel? get userModel => _userModel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  checkLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> getUserProfile() async {
    checkLoading(true);
    try {
      final data = await _userService.getUserProfile();
      _userModel = data;
      // print(data.id.toString());

      checkLoading(false);

      return true;
    } catch (e) {
      // print(e.toString());
      checkLoading(false);

      return false;
    }
  }

  Future<bool> calculateBMI(
    String height,
    weight,
  ) async {
    checkLoading(true);

    try {
      final data = await _userService.calculateBMI(height, weight);
      _userModel = data;

      if (_userModel!.status == 200) {
        checkLoading(false);

        return true;
      } else {
        checkLoading(false);

        return false;
      }
    } catch (e) {
      checkLoading(false);

      return false;
    }
  }
}
