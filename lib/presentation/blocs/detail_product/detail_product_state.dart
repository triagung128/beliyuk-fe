part of 'detail_product_bloc.dart';

class DetailProductState extends Equatable {
  final Product? product;
  final RequestState state;
  final String message;
  final String wishlistMessage;
  final bool isAddedToWishlist;

  const DetailProductState({
    this.product,
    required this.state,
    required this.message,
    required this.wishlistMessage,
    required this.isAddedToWishlist,
  });

  @override
  List<Object?> get props {
    return [
      product,
      state,
      message,
      wishlistMessage,
      isAddedToWishlist,
    ];
  }

  DetailProductState copyWith({
    Product? product,
    RequestState? state,
    String? message,
    String? wishlistMessage,
    bool? isAddedToWishlist,
  }) {
    return DetailProductState(
      product: product ?? this.product,
      state: state ?? this.state,
      message: message ?? this.message,
      wishlistMessage: wishlistMessage ?? this.wishlistMessage,
      isAddedToWishlist: isAddedToWishlist ?? this.isAddedToWishlist,
    );
  }

  factory DetailProductState.inital() {
    return const DetailProductState(
      product: null,
      state: RequestState.empty,
      message: '',
      wishlistMessage: '',
      isAddedToWishlist: false,
    );
  }
}
