import 'package:equatable/equatable.dart';
import 'package:fic6_fe_beliyuk/data/datasources/category_remote_datasource.dart';
import 'package:fic6_fe_beliyuk/data/models/responses/list_category_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_all_category_event.dart';
part 'get_all_category_state.dart';

class GetAllCategoryBloc
    extends Bloc<GetAllCategoryEvent, GetAllCategoryState> {
  final CategoryRemoteDatasource _datasource;

  GetAllCategoryBloc(this._datasource) : super(GetAllCategoryInitial()) {
    on<DoGetAllCategoryEvent>((event, emit) async {
      emit(GetAllCategoryLoading());

      final result = await _datasource.getAllCategory();

      result.fold(
        (messageError) => emit(GetAllCategoryError(messageError)),
        (data) => emit(GetAllCategoryLoaded(data)),
      );
    });
  }
}
