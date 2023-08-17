import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/enum_state.dart';
import 'package:beliyuk/domain/entities/user.dart';
import 'package:beliyuk/domain/usecases/auth/get_auth.dart';
import 'package:beliyuk/domain/usecases/auth/login.dart';
import 'package:beliyuk/domain/usecases/auth/register.dart';
import 'package:beliyuk/domain/usecases/auth/remove_auth.dart';
import 'package:beliyuk/domain/usecases/auth/save_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Register register;
  final SaveAuth saveAuth;
  final GetAuth getAuth;
  final RemoveAuth removeAuth;

  AuthBloc({
    required this.login,
    required this.register,
    required this.saveAuth,
    required this.getAuth,
    required this.removeAuth,
  }) : super(AuthState.initial()) {
    on<DoLoginEvent>((event, emit) async {
      emit(state.copyWith(state: RequestState.loading));

      final String identifier = event.identifier;
      final String password = event.password;

      final result = await login.execute(
        identifier: identifier,
        password: password,
      );

      result.fold(
        (failure) => emit(state.copyWith(
          state: RequestState.error,
          message: failure.message,
        )),
        (data) {
          saveAuth.execute(data);
          emit(
            state.copyWith(
              state: RequestState.loaded,
              user: data,
              message: '',
            ),
          );
        },
      );
    });

    on<DoRegisterEvent>((event, emit) async {
      emit(state.copyWith(state: RequestState.loading));

      final String username = event.username;
      final String email = event.email;
      final String password = event.password;

      final result = await register.execute(
        username: username,
        email: email,
        password: password,
      );

      result.fold(
        (failure) => emit(state.copyWith(
          state: RequestState.error,
          message: failure.message,
        )),
        (data) {
          saveAuth.execute(data);
          emit(
            state.copyWith(
              state: RequestState.loaded,
              user: data,
              message: '',
            ),
          );
        },
      );
    });

    on<DoAuthCheckEvent>((event, emit) async {
      emit(state.copyWith(state: RequestState.loading));

      final auth = await getAuth.execute();

      if (auth != null) {
        emit(
          state.copyWith(
            state: RequestState.loaded,
            user: auth,
            message: '',
          ),
        );
      } else {
        emit(
          state.copyWith(
            state: RequestState.loaded,
            user: null,
            message: '',
          ),
        );
      }
    });

    on<DoLogoutEvent>((event, emit) async {
      emit(state.copyWith(state: RequestState.loading));

      await removeAuth.execute();

      emit(
        state.copyWith(
          user: null,
          state: RequestState.empty,
          message: '',
        ),
      );
    });
  }
}
