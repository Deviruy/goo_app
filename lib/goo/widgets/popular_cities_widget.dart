import 'package:flutter/material.dart';
import 'package:goo_app/goo/models/city_model.dart';
import 'package:goo_app/goo/pages/home_page.dart';

import 'widgets.dart';

class PopularCitiesWidget extends StatelessWidget {
  const PopularCitiesWidget({
    super.key,
    required this.popularCities,
  });

  final List<CityModel> popularCities;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Text(
                'Popular',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: popularCities.length,
            itemBuilder: (context, index) {
              final popularCitie = popularCities[index];
              return CityShowcase(city: popularCitie);
            },
          ),
        ),
      ],
    );
  }
}
