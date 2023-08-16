import 'package:beliyuk/data/models/user_model.dart';

class AuthResponseModel {
  final String jwt;
  final UserModel user;

  AuthResponseModel({
    required this.jwt,
    required this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthResponseModel(
        jwt: json["jwt"],
        user: UserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "jwt": jwt,
        "user": user.toJson(),
      };
}
