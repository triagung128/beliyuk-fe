import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:beliyuk/common/enum_state.dart';
import 'package:beliyuk/domain/entities/address.dart';
import 'package:beliyuk/presentation/blocs/checkout/checkout_bloc.dart';
import 'package:beliyuk/presentation/common_widgets/title_bottom_sheet.dart';
import 'package:beliyuk/presentation/common_widgets/top_box_bottom_sheet.dart';

class InputAddressPage extends StatefulWidget {
  final Address? address;
  final int totalWeight;

  const InputAddressPage({
    super.key,
    this.address,
    required this.totalWeight,
  });

  @override
  State<InputAddressPage> createState() => _InputAddressPageState();
}

class _InputAddressPageState extends State<InputAddressPage> {
  final GlobalKey<FormState> _addressFormKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _provinceSearchController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _citySearchController = TextEditingController();

  final RoundedRectangleBorder _shapeBottomSheet = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
    ),
  );

  Province? _provinceSelected;
  City? _citySelected;

  @override
  void initState() {
    super.initState();

    if (widget.address != null) {
      _nameController.text = widget.address!.name;
      _phoneNumberController.text = widget.address!.phoneNumber;
      _addressController.text = widget.address!.address;
      _provinceController.text = widget.address!.province.province;
      _cityController.text =
          '${widget.address!.city.type} ${widget.address!.city.cityName}';

      _provinceSelected = widget.address!.province;
      _citySelected = widget.address!.city;

      context
          .read<CheckoutBloc>()
          .add(DoGetAllCities(widget.address!.province.provinceId));
    } else {
      Future.microtask(() {
        context.read<CheckoutBloc>().add(DoGetAllProvinces());
        context.read<CheckoutBloc>().add(DoClearAllCities());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double heightBetweenForm = 16;
    double heightBetweenLabel = 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alamat Pengiriman'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _addressFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Nama Peneriman'),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  maxLines: 1,
                  decoration: _inputDecoration(
                    hintText: 'Nama Penerima',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama Penerima tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: heightBetweenForm),
                const Text('No. Handphone'),
                SizedBox(height: heightBetweenLabel),
                TextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  maxLines: 1,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(15),
                  ],
                  decoration: _inputDecoration(
                    hintText: 'No. Handphone',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'No. Handphone tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: heightBetweenForm),
                const Text('Alamat Lengkap'),
                SizedBox(height: heightBetweenLabel),
                TextFormField(
                  controller: _addressController,
                  keyboardType: TextInputType.streetAddress,
                  maxLines: 4,
                  decoration: _inputDecoration(
                    hintText: 'Alamat Lengkap',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Alamat Lengkap tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: heightBetweenForm),
                const Text('Provinsi'),
                SizedBox(height: heightBetweenLabel),
                TextFormField(
                  controller: _provinceController,
                  readOnly: true,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      shape: _shapeBottomSheet,
                      builder: (_) => _buildProvincesBottomSheet(),
                    );
                  },
                  decoration: _inputDecoration(
                    hintText: 'Pilih Provinsi',
                  ).copyWith(
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Provinsi tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: heightBetweenForm),
                const Text('Kota'),
                SizedBox(height: heightBetweenLabel),
                TextFormField(
                  controller: _cityController,
                  enabled: _provinceSelected == null ? false : true,
                  readOnly: true,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      shape: _shapeBottomSheet,
                      builder: (_) => _buildCityBottomSheet(),
                    );
                  },
                  decoration: _inputDecoration(
                    hintText: _provinceSelected == null
                        ? 'Pilih Provinsi Terlebih Dahulu'
                        : 'Pilih Kota',
                  ).copyWith(
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kota tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 48),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_addressFormKey.currentState!.validate()) {
                      FocusManager.instance.primaryFocus?.unfocus();

                      final Address address = Address(
                        name: _nameController.text,
                        phoneNumber: _phoneNumberController.text,
                        address: _addressController.text,
                        province: _provinceSelected!,
                        city: _citySelected!,
                      );

                      context.read<CheckoutBloc>().add(DoSaveAddress(
                            address: address,
                            totalWeight: widget.totalWeight,
                          ));

                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 48),
                  ),
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProvincesBottomSheet() {
    return Column(
      children: [
        const TopBoxBottomSheet(),
        const TitleBottomSheet(titleText: 'Pilih Provinsi'),
        BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state.provincesState == RequestState.loaded) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _provinceSearchController,
                  onChanged: (value) {
                    context
                        .read<CheckoutBloc>()
                        .add(DoSearchProvinceOnQueryChanged(value));
                  },
                  decoration: _inputDecoration(
                    hintText: 'Masukkan nama provinsi',
                  ).copyWith(
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
        const SizedBox(height: 12),
        const Divider(thickness: 0.5, height: 0),
        Expanded(
          child: BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              if (state.provincesState == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.provincesState == RequestState.loaded) {
                return ListView.separated(
                  // shrinkWrap: true,
                  // primary: false,
                  itemCount: state.provinces.length,
                  separatorBuilder: (_, __) => const Divider(
                    thickness: 0.5,
                    height: 0,
                  ),
                  itemBuilder: (context, index) {
                    final Province province = state.provinces[index];

                    return ListTile(
                      onTap: () {
                        _provinceController.text = province.province;
                        _cityController.text = '';
                        _citySelected = null;

                        setState(() {
                          _provinceSelected = province;
                        });

                        context
                            .read<CheckoutBloc>()
                            .add(DoGetAllCities(province.provinceId));

                        Navigator.pop(context);
                      },
                      title: Text(province.province),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                      ),
                    );
                  },
                );
              }

              if (state.provincesState == RequestState.error) {
                return Center(
                  child: Text(state.provincesMessage),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCityBottomSheet() {
    return Column(
      children: [
        const TopBoxBottomSheet(),
        const TitleBottomSheet(titleText: 'Pilih Kota'),
        BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            if (state.citiesState == RequestState.loaded) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _citySearchController,
                  onChanged: (value) {
                    context
                        .read<CheckoutBloc>()
                        .add(DoSearchCityOnQueryChanged(value));
                  },
                  decoration: _inputDecoration(
                    hintText: 'Masukkan nama kota',
                  ).copyWith(
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
        const SizedBox(height: 12),
        const Divider(thickness: 0.5, height: 0),
        Expanded(
          child: BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              if (state.citiesState == RequestState.initial) {
                return const Center(
                  child: Text('Pilih provinsi terlebih dahulu'),
                );
              }

              if (state.citiesState == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.citiesState == RequestState.loaded) {
                return ListView.separated(
                  itemCount: state.cities.length,
                  separatorBuilder: (_, __) => const Divider(
                    thickness: 0.5,
                    height: 0,
                  ),
                  itemBuilder: (context, index) {
                    final City city = state.cities[index];

                    return ListTile(
                      onTap: () {
                        _cityController.text = '${city.type} ${city.cityName}';
                        _citySelected = city;

                        Navigator.pop(context);
                      },
                      title: Text('${city.type} ${city.cityName}'),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                      ),
                    );
                  },
                );
              }

              if (state.citiesState == RequestState.error) {
                return Center(
                  child: Text(state.citiesMessage),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({String? hintText}) => InputDecoration(
        isDense: true,
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _provinceController.dispose();
    _provinceSearchController.dispose();
    _cityController.dispose();
    _citySearchController.dispose();
  }
}
