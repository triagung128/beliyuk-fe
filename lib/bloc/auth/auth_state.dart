part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String? token;
  final UserModel? user;
  final RequestState state;
  final String message;

  const AuthState({
    required this.token,
    required this.user,
    required this.state,
    required this.message,
  });

  AuthState copyWith({
    String? token,
    UserModel? user,
    RequestState? state,
    String? message,
  }) {
    return AuthState(
      token: token ?? this.token,
      user: user ?? this.user,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }

  factory AuthState.initial() {
    return const AuthState(
      token: null,
      user: null,
      state: RequestState.initial,
      message: '',
    );
  }

  @override
  List<Object?> get props => [
        token,
        user,
        state,
        message,
      ];
}
