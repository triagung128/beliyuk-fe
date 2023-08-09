part of 'get_all_banner_bloc.dart';

sealed class GetAllBannerEvent extends Equatable {
  const GetAllBannerEvent();

  @override
  List<Object> get props => [];
}

final class DoGetAllBannerEvent extends GetAllBannerEvent {}
