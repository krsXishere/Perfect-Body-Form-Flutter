import 'package:flutter/material.dart';
import 'package:perfect_body_form/models/detail_achievement_model.dart';
import 'package:perfect_body_form/services/achievement_service.dart';
import 'package:perfect_body_form/services/detail_achievement_service.dart';

class DetailAchievementProvider with ChangeNotifier {
  final _achievementService = AchievementService();
  final _detailAchievementService = DetailAchievementService();
  List<DetailAchievementModel> _detailAchievementModels = [];
  List<DetailAchievementModel> get detailAchievementModels => _detailAchievementModels;
  double? _achievement;
  double? get achievement => _achievement;
  DetailAchievementModel? _detailAchievementModel;
  DetailAchievementModel? get detailAchievementModel => _detailAchievementModel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  checkLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> getDetailAchievements() async {
    checkLoading(true);

    try {
      final data = await _detailAchievementService.getDetailAchievements();
      _detailAchievementModels = data;
      // for(var e in data) {
      //   print("$e");
      // }
      checkLoading(false);

      return true;
    } catch (e) {
      checkLoading(false);

      return false;
    }
  }

  Future<bool> getAchievement() async {
    checkLoading(true);

    try {
      final data = await _achievementService.getAchievement();
      _achievement = data;
      checkLoading(false);

       return true;
    } catch (e) {
      checkLoading(false);

      return false;
    }
  }

  Future<bool> createAchievement(String exerciseId) async {
    checkLoading(true);

    try {
      final data = await _achievementService.createAchievement(exerciseId);
      _detailAchievementModel = data;
      checkLoading(false);

      return true;
    } catch (e) {
      checkLoading(false);

      return false;
    }
  }
}