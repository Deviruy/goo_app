import 'package:flutter/material.dart';
import 'package:goo_app/goo/models/city_model.dart';

class RecomendedCitiesWidget extends StatelessWidget {
  const RecomendedCitiesWidget({
    super.key,
    required this.recommendedCities,
  });

  final List<CityModel> recommendedCities;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Recommended',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 22, left: 16, right: 16, top: 8),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.3,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(recommendedCities.length, (index) {
              final recommendedCity = recommendedCities[index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/city-details',
                    arguments: recommendedCity),
                child: Container(
                  height: 1,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .7),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 16,
                          offset: const Offset(-2, 2),
                        ),
                      ]),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Hero(
                                tag: recommendedCity.assetPath,
                                child: Image.asset(
                                  recommendedCity.assetPath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, bottom: 8),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            recommendedCity.name,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20, right: 15),
                          child: Container(
                            padding: EdgeInsets.all(3),
                            height: 30,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: .6),
                                borderRadius: BorderRadius.circular(25)),
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade700,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 14,
                                      ),
                                      Text(
                                        recommendedCity.rating.toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}
