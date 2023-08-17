part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class DoLoginEvent extends AuthEvent {
  final String identifier;
  final String password;

  const DoLoginEvent({
    required this.identifier,
    required this.password,
  });

  @override
  List<Object> get props => [identifier, password];
}

final class DoRegisterEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;

  const DoRegisterEvent({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [username, email, password];
}

final class DoAuthCheckEvent extends AuthEvent {}

final class DoLogoutEvent extends AuthEvent {}
