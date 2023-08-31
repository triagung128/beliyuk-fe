// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'main_bloc.dart';

class MainState extends Equatable {
  final int tabIndex;
  final bool isLogin;

  const MainState({
    required this.tabIndex,
    required this.isLogin,
  });

  MainState copyWith({
    int? tabIndex,
    bool? isLogin,
  }) {
    return MainState(
      tabIndex: tabIndex ?? this.tabIndex,
      isLogin: isLogin ?? this.isLogin,
    );
  }

  factory MainState.initial() => const MainState(
        tabIndex: 0,
        isLogin: false,
      );

  @override
  List<Object> get props => [tabIndex, isLogin];
}
