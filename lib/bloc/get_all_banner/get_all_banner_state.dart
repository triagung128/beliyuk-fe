part of 'get_all_banner_bloc.dart';

sealed class GetAllBannerState extends Equatable {
  const GetAllBannerState();

  @override
  List<Object> get props => [];
}

final class GetAllBannerInitial extends GetAllBannerState {}

final class GetAllBannerLoading extends GetAllBannerState {}

final class GetAllBannerLoaded extends GetAllBannerState {
  final ListBannerResponseModel data;

  const GetAllBannerLoaded(this.data);

  @override
  List<Object> get props => [data];
}

final class GetAllBannerError extends GetAllBannerState {
  final String messageError;

  const GetAllBannerError(this.messageError);

  @override
  List<Object> get props => [messageError];
}
