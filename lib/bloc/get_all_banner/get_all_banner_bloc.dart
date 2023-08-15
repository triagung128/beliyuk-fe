import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic6_fe_beliyuk/data/datasources/remote/banner_remote_datasource.dart';
import 'package:fic6_fe_beliyuk/data/models/responses/list_banner_response_model.dart';

part 'get_all_banner_event.dart';
part 'get_all_banner_state.dart';

class GetAllBannerBloc extends Bloc<GetAllBannerEvent, GetAllBannerState> {
  final BannerRemoteDatasource _datasource;

  GetAllBannerBloc(this._datasource) : super(GetAllBannerInitial()) {
    on<GetAllBannerEvent>((event, emit) async {
      emit(GetAllBannerLoading());

      final result = await _datasource.getAllBanner();

      result.fold(
        (messageError) => emit(GetAllBannerError(messageError)),
        (data) => emit(GetAllBannerLoaded(data)),
      );
    });
  }
}
