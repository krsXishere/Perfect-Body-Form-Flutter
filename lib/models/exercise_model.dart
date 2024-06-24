class ExerciseModel {
  int? id, setTypeId, bodyMassStandartId, status;
  String? exerciseName, time, instructions, setType, bodyMassStandart, message;

  ExerciseModel({
    required this.id,
    required this.setTypeId,
    required this.bodyMassStandartId,
    required this.exerciseName,
    required this.time,
    required this.instructions,
    required this.setType,
    required this.bodyMassStandart,
    required this.status,
    required this.message,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> object) {
    return ExerciseModel(
      id: object['data']['id'],
      setTypeId: object['data']['set_type_id'],
      bodyMassStandartId: object['data']['body_mass_standart_id'],
      exerciseName: object['data']['exercise_name'],
      time: object['data']['time'],
      instructions: object['data']['instructions'],
      setType: object['data']['set_type']['set_type'],
      bodyMassStandart: object['data']['body_mass_standart']['standard'],
      status: object['status'],
      message: object['message'],
    );
  }
}
