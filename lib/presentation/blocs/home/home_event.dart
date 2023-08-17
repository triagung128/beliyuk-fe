part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class DoGetAllBanners extends HomeEvent {}

final class DoGetAllCategories extends HomeEvent {}

final class DoGetAllProducts extends HomeEvent {}
