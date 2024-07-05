class DetailAchievementModel {
  int? id, achievementId, exerciseId;
  bool? status;

  DetailAchievementModel({
    required this.id,
    required this.achievementId,
    required this.exerciseId,
    required this.status,
  });

  factory DetailAchievementModel.fromJson(Map<String, dynamic> object) {
    return DetailAchievementModel(
      id: object['id'],
      achievementId: object['achievement_id'],
      exerciseId: object['exercise_id'],
      status: object['status'] == 0 ? false : true,
    );
  }
}
