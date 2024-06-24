import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  bool _isDismiss = false;
  bool get isDismiss => _isDismiss;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _bmi = "0";
  String get bmi => _bmi;

  checkLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  setDismiss(bool value) {
    _isDismiss = value;
    notifyListeners();
  }

  calculateOfflineBMI(
    String height,
    weight,
  ) {
    checkLoading(true);

    try {
      double convertedHeight = double.parse(height) / 100;
      double heightSquare = convertedHeight * convertedHeight;
      double result = double.parse(weight) / heightSquare;
      _bmi = result.toStringAsFixed(1);

      checkLoading(false);
    } catch (e) {
      checkLoading(false);
      // print("$e");
      throw Exception("Error $e");
    }

    notifyListeners();
  }
}
