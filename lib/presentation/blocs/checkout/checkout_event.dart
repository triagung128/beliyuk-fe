part of 'checkout_bloc.dart';

sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

final class DoGetAllProvinces extends CheckoutEvent {}

final class DoSearchProvinceOnQueryChanged extends CheckoutEvent {
  final String query;

  const DoSearchProvinceOnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

final class DoGetAllCities extends CheckoutEvent {
  final String provinceId;

  const DoGetAllCities(this.provinceId);

  @override
  List<Object> get props => [provinceId];
}

final class DoSearchCityOnQueryChanged extends CheckoutEvent {
  final String query;

  const DoSearchCityOnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

final class DoClearAllCities extends CheckoutEvent {}

final class DoSaveAddress extends CheckoutEvent {
  final Address address;
  final int totalWeight;

  const DoSaveAddress({
    required this.address,
    required this.totalWeight,
  });

  @override
  List<Object> get props => [address, totalWeight];
}

final class DoGetCourier extends CheckoutEvent {
  final String destination;
  final int weight;

  const DoGetCourier({
    required this.destination,
    required this.weight,
  });

  @override
  List<Object> get props => [destination, weight];
}

final class DoSelectCourierService extends CheckoutEvent {
  final CourierService courierService;

  const DoSelectCourierService(this.courierService);

  @override
  List<Object> get props => [courierService];
}

final class DoSetCartItems extends CheckoutEvent {
  final List<Cart> carts;
  final int totalPriceProduct;
  final int totalWeight;

  const DoSetCartItems({
    required this.carts,
    required this.totalPriceProduct,
    required this.totalWeight,
  });

  @override
  List<Object> get props => [carts, totalPriceProduct, totalWeight];
}
