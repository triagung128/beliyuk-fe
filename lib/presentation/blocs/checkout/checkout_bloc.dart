import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/enum_state.dart';
import 'package:beliyuk/domain/entities/address.dart';
import 'package:beliyuk/domain/entities/cart.dart';
import 'package:beliyuk/domain/entities/courier.dart';
import 'package:beliyuk/domain/usecases/address/get_all_cities.dart';
import 'package:beliyuk/domain/usecases/address/get_all_provinces.dart';
import 'package:beliyuk/domain/usecases/courier/get_cost.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final GetAllProvinces getAllProvinces;
  final GetAllCities getAllCities;
  final GetCost getCost;

  final List<Province> _provinces = [];
  final List<City> _cities = [];

  CheckoutBloc({
    required this.getAllProvinces,
    required this.getAllCities,
    required this.getCost,
  }) : super(CheckoutState.initial()) {
    on<DoGetAllProvinces>((event, emit) async {
      emit(state.copyWith(
        provincesState: RequestState.loading,
        selectedCourierService: state.selectedCourierService,
      ));

      final result = await getAllProvinces.execute();

      result.fold(
        (failure) => emit(state.copyWith(
          provincesState: RequestState.error,
          provincesMessage: failure.message,
          selectedCourierService: state.selectedCourierService,
        )),
        (data) {
          _provinces.addAll(data);
          emit(state.copyWith(
            provincesState: RequestState.loaded,
            provinces: data,
            selectedCourierService: state.selectedCourierService,
          ));
        },
      );
    });

    on<DoSearchProvinceOnQueryChanged>((event, emit) {
      final List<Province> result = _provinces
          .where((item) => item.province.toLowerCase().contains(event.query))
          .toList();

      emit(state.copyWith(
        provincesState: RequestState.loaded,
        provinces: result,
        selectedCourierService: state.selectedCourierService,
      ));
    });

    on<DoGetAllCities>((event, emit) async {
      emit(state.copyWith(
        citiesState: RequestState.loading,
        selectedCourierService: state.selectedCourierService,
      ));

      final result = await getAllCities.execute(event.provinceId);

      result.fold(
        (failure) => emit(state.copyWith(
          citiesState: RequestState.error,
          citiesMessage: failure.message,
          selectedCourierService: state.selectedCourierService,
        )),
        (data) {
          _cities.addAll(data);
          emit(state.copyWith(
            citiesState: RequestState.loaded,
            cities: data,
            selectedCourierService: state.selectedCourierService,
          ));
        },
      );
    });

    on<DoSearchCityOnQueryChanged>((event, emit) {
      final List<City> result = _cities
          .where((item) => '${item.type} ${item.cityName}'
              .toLowerCase()
              .contains(event.query))
          .toList();

      emit(state.copyWith(
        citiesState: RequestState.loaded,
        cities: result,
        selectedCourierService: state.selectedCourierService,
      ));
    });

    on<DoClearAllCities>((event, emit) {
      emit(state.copyWith(
        cities: [],
        citiesMessage: '',
        citiesState: RequestState.initial,
        selectedCourierService: state.selectedCourierService,
      ));
    });

    on<DoSaveAddress>((event, emit) {
      emit(state.copyWith(
        address: event.address,
        selectedCourierService: state.selectedCourierService,
      ));

      add(DoGetCourier(
        destination: event.address.city.cityId,
        weight: event.totalWeight,
      ));
    });

    on<DoGetCourier>((event, emit) async {
      emit(state.copyWith(
        courierState: RequestState.loading,
        selectedCourierService: state.selectedCourierService,
      ));

      final int totalPriceProduct = state.totalPriceProduct;

      final result = await getCost.execute(
        destination: event.destination,
        weight: event.weight,
      );

      result.fold(
        (failure) => emit(state.copyWith(
          courierState: RequestState.error,
          courierMessage: failure.message,
          selectedCourierService: state.selectedCourierService,
        )),
        (data) {
          if (data.costs.isNotEmpty) {
            final totalShippingCost = data.costs.first.cost.value;
            emit(state.copyWith(
              courierState: RequestState.loaded,
              courier: data,
              selectedCourierService: data.costs.first,
              subtotal: _sumSubtotal(
                totalPriceProduct: totalPriceProduct,
                totalShippingCost: totalShippingCost,
              ),
            ));
          } else {
            emit(state.copyWith(
              courierState: RequestState.empty,
              courier: data,
              selectedCourierService: null,
              subtotal: _sumSubtotal(totalPriceProduct: totalPriceProduct),
            ));
          }
        },
      );
    });

    on<DoSelectCourierService>((event, emit) {
      final int totalPriceProduct = state.totalPriceProduct;
      final int totalShippingCost = event.courierService.cost.value;

      emit(state.copyWith(
        selectedCourierService: event.courierService,
        subtotal: _sumSubtotal(
          totalPriceProduct: totalPriceProduct,
          totalShippingCost: totalShippingCost,
        ),
      ));
    });

    on<DoSetCartItems>((event, emit) {
      final int totalPriceProduct = event.totalPriceProduct;

      emit(state.copyWith(
        carts: event.carts,
        totalPriceProduct: event.totalPriceProduct,
        totalWeight: event.totalWeight,
        subtotal: _sumSubtotal(totalPriceProduct: totalPriceProduct),
        selectedCourierService: state.selectedCourierService,
      ));
    });
  }

  int _sumSubtotal({int totalPriceProduct = 0, int totalShippingCost = 0}) {
    return totalPriceProduct + totalShippingCost;
  }
}
