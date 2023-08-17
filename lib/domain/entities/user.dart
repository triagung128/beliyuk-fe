import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String token;
  final int id;
  final String username;
  final String email;

  const User({
    required this.token,
    required this.id,
    required this.username,
    required this.email,
  });

  @override
  List<Object> get props => [token, id, username, email];
}
