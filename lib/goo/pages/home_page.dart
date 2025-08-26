import 'package:flutter/material.dart';
import 'package:goo_app/goo/models/city_model.dart';
import 'package:goo_app/goo/repository/city_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<CityModel>> cities;

  @override
  void initState() {
    super.initState();
    cities = CityRepository().loadCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
