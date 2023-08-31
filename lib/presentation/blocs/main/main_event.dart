part of 'main_bloc.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

final class DoTabChangeEvent extends MainEvent {
  final int tabIndex;

  const DoTabChangeEvent({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}

final class DoIsLoginEvent extends MainEvent {}
