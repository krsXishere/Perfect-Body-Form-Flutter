class UserModel {
  int? id, genderId, status;
  double? bmi;
  String? name, height, weight, email, profilePhotoURL, gender, message;

  UserModel({
    required this.id,
    required this.genderId,
    required this.name,
    required this.height,
    required this.weight,
    required this.bmi,
    required this.email,
    required this.profilePhotoURL,
    required this.gender,
    required this.status,
    required this.message,
  });

  factory UserModel.fromJson(Map<String, dynamic> object) {
    return UserModel(
      id: object['data']['id'],
      genderId: object['data']['gender_id'],
      name: object['data']['name'],
      height: object['data']['height'],
      weight: object['data']['weight'],
      bmi: parseDouble(object['data']['bmi']) ?? 0,
      email: object['data']['email'],
      profilePhotoURL: object['data']['profile_photo_url'],
      gender: object['data']['gender']['gender'],
      status: object['status'],
      message: object['message'],
    );
  }

  static double? parseDouble(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is int) {
      return value.toDouble();
    }
    if (value is double) {
      return value;
    }
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }
}
