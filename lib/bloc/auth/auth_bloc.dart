import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic6_fe_beliyuk/common/enum_state.dart';
import 'package:fic6_fe_beliyuk/data/datasources/auth_local_datasource.dart';
import 'package:fic6_fe_beliyuk/data/datasources/auth_remote_datasource.dart';
import 'package:fic6_fe_beliyuk/data/models/requests/login_request_model.dart';
import 'package:fic6_fe_beliyuk/data/models/requests/register_request_model.dart';
import 'package:fic6_fe_beliyuk/data/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRemoteDatasource remoteDatasource;
  final AuthLocalDatasource localDatasource;

  AuthBloc({
    required this.remoteDatasource,
    required this.localDatasource,
  }) : super(AuthState.initial()) {
    on<DoLoginEvent>((event, emit) async {
      emit(state.copyWith(state: RequestState.loading));

      final result = await remoteDatasource.login(event.request);
      result.fold(
        (messageError) => emit(state.copyWith(
          state: RequestState.error,
          message: messageError,
        )),
        (data) {
          localDatasource.saveAuth(data);
          emit(
            state.copyWith(
              state: RequestState.loaded,
              token: data.jwt,
              user: data.user,
              message: '',
            ),
          );
        },
      );
    });

    on<DoRegisterEvent>((event, emit) async {
      emit(state.copyWith(state: RequestState.loading));

      final result = await remoteDatasource.register(event.request);
      result.fold(
        (messageError) => emit(state.copyWith(
          state: RequestState.error,
          message: messageError,
        )),
        (data) {
          localDatasource.saveAuth(data);
          emit(
            state.copyWith(
              state: RequestState.loaded,
              token: data.jwt,
              user: data.user,
              message: '',
            ),
          );
        },
      );
    });

    on<DoAuthCheckEvent>((event, emit) async {
      emit(state.copyWith(state: RequestState.loading));

      final auth = await localDatasource.getAuth();

      if (auth != null) {
        emit(
          state.copyWith(
            state: RequestState.loaded,
            token: auth.jwt,
            user: auth.user,
            message: '',
          ),
        );
      } else {
        emit(
          state.copyWith(
            state: RequestState.loaded,
            token: null,
            user: null,
            message: '',
          ),
        );
      }
    });

    on<DoLogoutEvent>((event, emit) async {
      emit(state.copyWith(state: RequestState.loading));

      await localDatasource.removeAuth();

      emit(
        state.copyWith(
          token: null,
          user: null,
          state: RequestState.empty,
          message: '',
        ),
      );
    });
  }
}
