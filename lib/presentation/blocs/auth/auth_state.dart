part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final User? user;
  final RequestState state;
  final String message;

  const AuthState({
    required this.user,
    required this.state,
    required this.message,
  });

  AuthState copyWith({
    User? user,
    RequestState? state,
    String? message,
  }) {
    return AuthState(
      user: user ?? this.user,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }

  factory AuthState.initial() {
    return const AuthState(
      user: null,
      state: RequestState.initial,
      message: '',
    );
  }

  @override
  List<Object?> get props => [user, state, message];
}
