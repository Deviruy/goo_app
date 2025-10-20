import 'package:flutter/material.dart';
import 'package:goo_app/goo/models/city_model.dart';
import 'package:goo_app/goo/repository/city_repository.dart';

import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<CityModel>> cities;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    cities = CityRepository().loadCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<CityModel>>(
          future: cities,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhuma cidade encontrada'));
            }

            final cities = snapshot.data!;

            final filteredCities = cities.where((city) {
              final query = searchQuery.toLowerCase();
              return city.name.toLowerCase().contains(query);
            }).toList();

            final popularCities =
                filteredCities.where((c) => c.rating > 4.7).toList();
            final recommendedCities =
                filteredCities.where((c) => c.rating <= 4.7).toList();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  const HomeHeaderWidget(),
                  const SizedBox(height: 28),

                  // Search
                  HomeSearchWidget(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),

                  // Cities
                  if (searchQuery.isEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Popular Cities Section
                        PopularCitiesWidget(popularCities: popularCities),

                        // Recomended Cities Section
                        RecomendedCitiesWidget(
                            recommendedCities: recommendedCities),
                      ],
                    ),

                  // No filtered cities found
                  if (filteredCities.isEmpty)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: Center(
                            child: Text(
                              'No cities found.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  // Filtered Cities founded
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: .75,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(filteredCities.length, (index) {
                      final searchedCity = filteredCities[index];
                      return CityShowcase(city: searchedCity);
                    }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
