import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:beliyuk/data/models/province_model.dart';
import 'package:beliyuk/data/models/responses/province_list_response_model.dart';

abstract class AddressLocalDataSource {
  Future<List<ProvinceModel>> getAllProvinces();
}

class AddressLocalDataSourceImpl implements AddressLocalDataSource {
  @override
  Future<List<ProvinceModel>> getAllProvinces() async {
    final response = await rootBundle.loadString('assets/json/province.json');
    return ProvinceListReponseModel.fromJson(json.decode(response)).results;
  }
}
