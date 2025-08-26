import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:goo_app/goo/models/city_model.dart';

class CityRepository {
  Future<List<CityModel>> loadCities() async {
    final String response =
        await rootBundle.loadString('assets/data/cities.json');

    final List<dynamic> data = jsonDecode(response);

    final List<CityModel> citiesModel = CityModel.fromJsonToList(data);
    return citiesModel;
  }
}
