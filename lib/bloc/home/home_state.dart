part of 'home_bloc.dart';

class HomeState extends Equatable {
  final ListBannerResponseModel? banners;
  final RequestState bannersState;
  final String bannersMessage;
  final ListCategoryResponseModel? categories;
  final RequestState categoriesState;
  final String categoriesMessage;
  final ListProductResponseModel? products;
  final RequestState productsState;
  final String productsMessage;

  const HomeState({
    required this.banners,
    required this.bannersState,
    required this.bannersMessage,
    required this.categories,
    required this.categoriesState,
    required this.categoriesMessage,
    required this.products,
    required this.productsState,
    required this.productsMessage,
  });

  HomeState copyWith({
    ListBannerResponseModel? banners,
    RequestState? bannersState,
    String? bannersMessage,
    ListCategoryResponseModel? categories,
    RequestState? categoriesState,
    String? categoriesMessage,
    ListProductResponseModel? products,
    RequestState? productsState,
    String? productsMessage,
  }) =>
      HomeState(
        banners: banners ?? this.banners,
        bannersState: bannersState ?? this.bannersState,
        bannersMessage: bannersMessage ?? this.bannersMessage,
        categories: categories ?? this.categories,
        categoriesState: categoriesState ?? this.categoriesState,
        categoriesMessage: categoriesMessage ?? this.categoriesMessage,
        products: products ?? this.products,
        productsState: productsState ?? this.productsState,
        productsMessage: productsMessage ?? this.productsMessage,
      );

  factory HomeState.initial() => const HomeState(
        banners: null,
        bannersState: RequestState.initial,
        bannersMessage: '',
        categories: null,
        categoriesState: RequestState.initial,
        categoriesMessage: '',
        products: null,
        productsState: RequestState.initial,
        productsMessage: '',
      );

  @override
  List<Object?> get props => [
        banners,
        bannersState,
        bannersMessage,
        categories,
        categoriesState,
        categoriesMessage,
        products,
        productsState,
        productsMessage,
      ];
}
