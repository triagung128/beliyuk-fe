part of 'checkout_bloc.dart';

class CheckoutState extends Equatable {
  final Address? address;
  final List<Province> provinces;
  final RequestState provincesState;
  final String provincesMessage;
  final List<City> cities;
  final RequestState citiesState;
  final String citiesMessage;
  final Courier? courier;
  final RequestState courierState;
  final String courierMessage;
  final CourierService? selectedCourierService;
  final List<Cart> carts;
  final int totalPriceProduct;
  final int totalWeight;
  final int subtotal;

  const CheckoutState({
    this.address,
    required this.provinces,
    required this.provincesState,
    required this.provincesMessage,
    required this.cities,
    required this.citiesState,
    required this.citiesMessage,
    this.courier,
    required this.courierState,
    required this.courierMessage,
    this.selectedCourierService,
    required this.carts,
    this.totalPriceProduct = 0,
    this.totalWeight = 0,
    this.subtotal = 0,
  });

  CheckoutState copyWith({
    Address? address,
    List<Province>? provinces,
    RequestState? provincesState,
    String? provincesMessage,
    List<City>? cities,
    RequestState? citiesState,
    String? citiesMessage,
    Courier? courier,
    RequestState? courierState,
    String? courierMessage,
    required CourierService? selectedCourierService,
    List<Cart>? carts,
    int? totalPriceProduct,
    int? totalWeight,
    int? subtotal,
  }) {
    return CheckoutState(
      address: address ?? this.address,
      provinces: provinces ?? this.provinces,
      provincesState: provincesState ?? this.provincesState,
      provincesMessage: provincesMessage ?? this.provincesMessage,
      cities: cities ?? this.cities,
      citiesState: citiesState ?? this.citiesState,
      citiesMessage: citiesMessage ?? this.citiesMessage,
      courier: courier ?? this.courier,
      courierState: courierState ?? this.courierState,
      courierMessage: courierMessage ?? this.courierMessage,
      selectedCourierService: selectedCourierService,
      carts: carts ?? this.carts,
      totalPriceProduct: totalPriceProduct ?? this.totalPriceProduct,
      totalWeight: totalWeight ?? this.totalWeight,
      subtotal: subtotal ?? this.subtotal,
    );
  }

  factory CheckoutState.initial() => const CheckoutState(
        provinces: [],
        provincesState: RequestState.initial,
        provincesMessage: '',
        cities: [],
        citiesState: RequestState.initial,
        citiesMessage: '',
        courierState: RequestState.initial,
        courierMessage: '',
        carts: [],
      );

  @override
  List<Object?> get props => [
        address,
        provinces,
        provincesState,
        provincesMessage,
        cities,
        citiesState,
        citiesMessage,
        courier,
        courierState,
        courierMessage,
        selectedCourierService,
        carts,
        totalPriceProduct,
        totalWeight,
        subtotal,
      ];
}
