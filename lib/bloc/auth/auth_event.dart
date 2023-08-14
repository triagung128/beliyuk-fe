part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class DoLoginEvent extends AuthEvent {
  final LoginRequestModel request;

  const DoLoginEvent({
    required this.request,
  });

  @override
  List<Object> get props => [request];
}

final class DoRegisterEvent extends AuthEvent {
  final RegisterRequestModel request;

  const DoRegisterEvent({
    required this.request,
  });

  @override
  List<Object> get props => [request];
}

final class DoAuthCheckEvent extends AuthEvent {}

final class DoLogoutEvent extends AuthEvent {}
