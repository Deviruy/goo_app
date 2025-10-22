import 'package:flutter/material.dart';
import 'package:goo_app/goo/models/city_model.dart';

class CityShowcase extends StatelessWidget {
  final bool showInfo;
  const CityShowcase({super.key, required this.city, this.showInfo = true});

  final CityModel city;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Hero(
        tag: city.assetPath,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/city-details', arguments: city);
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            width: 220,
            height: 240,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(-2, 2),
                  ),
                ]),
            child: Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  height: double.infinity,
                  width: double.infinity,
                  city.assetPath,
                  fit: BoxFit.cover,
                ),
              ),
              if (showInfo) ...[
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, bottom: 56),
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: .7),
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 18),
                        child: Text(
                          city.name,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: .7),
                          borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            city.rating.toString(),
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
              ]
            ]),
          ),
        ),
      ),
    );
  }
}
