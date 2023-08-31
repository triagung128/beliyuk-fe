import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/domain/usecases/auth/get_auth.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final GetAuth getAuth;

  MainBloc({
    required this.getAuth,
  }) : super(MainState.initial()) {
    on<DoTabChangeEvent>((event, emit) {
      emit(state.copyWith(tabIndex: event.tabIndex));
    });

    on<DoIsLoginEvent>((event, emit) async {
      final result = await getAuth.execute();
      if (result != null) {
        emit(state.copyWith(isLogin: true));
      } else {
        emit(state.copyWith(isLogin: false));
      }
    });
  }
}
