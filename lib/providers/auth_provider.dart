import 'package:flutter/material.dart';
import 'package:perfect_body_form/models/auth_model.dart';
import 'package:perfect_body_form/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final _authService = AuthService();
  AuthModel? _authModel;
  AuthModel? get authModel => _authModel;
  bool _isObsecure = true;
  bool get isObsecure => _isObsecure;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isObsecureConfirmation = true;
  bool get isObsecureConfirmation => _isObsecureConfirmation;
  String? _genderId;
  String? get genderId => _genderId;

  checkObsecure() {
    _isObsecure = !_isObsecure;
    notifyListeners();
  }

  checkObsecureConfirmation() {
    _isObsecureConfirmation = !_isObsecureConfirmation;
    notifyListeners();
  }

  checkLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  checkGender(String? value) {
    if (value == "Laki-laki") {
      _genderId = "1";
    } else {
      _genderId = "2";
    }

    notifyListeners();
  }

  Future<bool> signUp(
    String name,
    String email,
    String password,
  ) async {
    checkLoading(true);

    try {
      final data = await _authService.signUp(
        name,
        email,
        password,
        _genderId.toString(),
      );

      _authModel = data;
      
      if (_authModel!.status == 200) {
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

  Future<bool> signIn(
    String email,
    String password,
  ) async {
    checkLoading(true);

    try {
      final data = await _authService.signIn(
        email,
        password,
      );

      _authModel = data;
      
      if (_authModel!.status == 200) {
        checkLoading(false);

        return true;
      } else {
        checkLoading(false);

        return false;
      }
    } catch (e) {
      Exception("Error: $e");
      checkLoading(false);

      return false;
    }
  }

  Future<bool> signOut() async {
    checkLoading(true);

    try {
      checkLoading(false);

      return await _authService.signOut();
    } catch (e) {
      Exception("Error: $e");
      checkLoading(false);

      return true;
    }
  }
}
