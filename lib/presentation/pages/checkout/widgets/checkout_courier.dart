import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/enum_state.dart';
import 'package:beliyuk/common/int_extensions.dart';
import 'package:beliyuk/domain/entities/courier.dart';
import 'package:beliyuk/presentation/blocs/checkout/checkout_bloc.dart';
import 'package:beliyuk/presentation/common_widgets/title_bottom_sheet.dart';
import 'package:beliyuk/presentation/common_widgets/top_box_bottom_sheet.dart';
import 'package:beliyuk/presentation/pages/checkout/widgets/title_checkout.dart';

class CheckoutCourier extends StatelessWidget {
  const CheckoutCourier({
    super.key,
    required this.scaffoldMessengerKey,
  });

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: state.courierState == RequestState.empty
              ? null
              : () {
                  if (state.address != null) {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      builder: (_) => _buildCourierServicesBottomSheet(),
                    );
                  } else {
                    scaffoldMessengerKey.currentState!
                      ..removeCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('Mohon lengkapi alamat pengiriman'),
                        ),
                      );
                  }
                },
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleCheckout(
                  text: 'Jasa Pengiriman',
                  icon: Icons.local_shipping,
                ),
                const SizedBox(height: 10),
                state.courierState == RequestState.empty
                    ? const Text(
                        'Mohon maaf sekali, daerah tersebut belum terjangkau oleh kurir kami.',
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: state.selectedCourierService != null &&
                                    state.courier != null
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.courier!.name,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            '${state.selectedCourierService!.service} (${state.selectedCourierService!.description})',
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Estimasi: ${_customFormatEtd(state.selectedCourierService!.cost.etd)}',
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                        ],
                                      ),
                                      Text(state.selectedCourierService!.cost
                                          .value.intToFormatRupiah),
                                    ],
                                  )
                                : const Text('Pilih Jasa Pengiriman'),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCourierServicesBottomSheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const TopBoxBottomSheet(),
        const TitleBottomSheet(titleText: 'Pilih Jasa Pengiriman'),
        BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state.courierState == RequestState.loading) {
              return const SizedBox(
                height: 250,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state.courierState == RequestState.empty) {
              return Container(
                height: 250,
                padding: const EdgeInsets.all(48),
                child: const Center(
                  child: Text(
                    'Mohon maaf sekali, daerah tersebut belum terjangkau oleh kurir kami.',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (state.courierState == RequestState.loaded) {
              return Expanded(
                child: ListView.separated(
                  separatorBuilder: (_, __) => const Divider(
                    thickness: 0.5,
                    height: 0,
                  ),
                  itemCount: state.courier!.costs.length,
                  itemBuilder: (context, index) {
                    final CourierService item = state.courier!.costs[index];
                    return ListTile(
                      onTap: () {
                        context
                            .read<CheckoutBloc>()
                            .add(DoSelectCourierService(item));

                        Navigator.pop(context);
                      },
                      title: Text(state.courier!.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${item.service} (${item.description})'),
                          const SizedBox(height: 6),
                          Text(
                            'Estimasi: ${_customFormatEtd(item.cost.etd)}',
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(item.cost.value.intToFormatRupiah),
                        ],
                      ),
                      isThreeLine: true,
                    );
                  },
                ),
              );
            }

            if (state.courierState == RequestState.error) {
              return SizedBox(
                height: 250,
                child: Center(
                  child: Text(state.courierMessage),
                ),
              );
            }

            return const SizedBox();
          },
        )
      ],
    );
  }

  String _customFormatEtd(String etd) {
    if (etd.contains('-')) {
      final List<String> array = etd.split('-');
      final String first = array[0];
      final String second = array[1];

      if (first == second) return '$first Hari';
      return '$first s/d $second Hari';
    } else {
      final List<String> array = etd.split('+');
      final String first = array[0];

      return '$first Hari Lebih';
    }
  }
}
