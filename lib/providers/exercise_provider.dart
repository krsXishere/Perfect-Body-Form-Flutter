import 'package:flutter/material.dart';
import 'package:perfect_body_form/models/exercise_model.dart';
import 'package:perfect_body_form/services/exercise_service.dart';

class ExerciseProvider with ChangeNotifier {
  final _exerciseService = ExerciseService();
  List<ExerciseModel> _exercises = [];
  List<ExerciseModel> get exercises => _exercises;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  checkLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> getExercises() async {
    checkLoading(true);

    try {
      final data = await _exerciseService.getExercises();
      _exercises = data;

      checkLoading(false);

      return false;
    } catch (e) {
      checkLoading(false);

      return false;
    }
  }
}