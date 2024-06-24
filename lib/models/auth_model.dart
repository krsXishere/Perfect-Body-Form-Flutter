class AuthModel {
  int? status;
  String? message, token;

  AuthModel({
    required this.status,
    required this.message,
    required this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> object) {
    return AuthModel(
      status: object['status'],
      message: object['message'],
      token: object['data']['token'],
    );
  }
}
