import 'package:equatable/equatable.dart';

import 'package:beliyuk/domain/entities/user.dart';

class UserModel extends Equatable {
  final String token;
  final int id;
  final String username;
  final String email;

  const UserModel({
    required this.token,
    required this.id,
    required this.username,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'jwt': token,
        'user': {
          'id': id,
          'username': username,
          'email': email,
        },
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json['jwt'],
        id: json['user']['id'],
        username: json['user']['username'],
        email: json['user']['email'],
      );

  User toEntity() => User(
        token: token,
        id: id,
        username: username,
        email: email,
      );

  factory UserModel.fromEntity(User user) => UserModel(
        token: user.token,
        id: user.id,
        username: user.username,
        email: user.email,
      );

  @override
  List<Object> get props => [token, id, username, email];
}
