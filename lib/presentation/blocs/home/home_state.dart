part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<Banner> banners;
  final RequestState bannersState;
  final String bannersMessage;
  final List<Category> categories;
  final RequestState categoriesState;
  final String categoriesMessage;
  final List<Product> products;
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
    List<Banner>? banners,
    RequestState? bannersState,
    String? bannersMessage,
    List<Category>? categories,
    RequestState? categoriesState,
    String? categoriesMessage,
    List<Product>? products,
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
        banners: [],
        bannersState: RequestState.initial,
        bannersMessage: '',
        categories: [],
        categoriesState: RequestState.initial,
        categoriesMessage: '',
        products: [],
        productsState: RequestState.initial,
        productsMessage: '',
      );

  @override
  List<Object> get props => [
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
