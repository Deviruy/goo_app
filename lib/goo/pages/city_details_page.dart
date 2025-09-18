import 'package:flutter/material.dart';
import 'package:goo_app/goo/models/city_model.dart';

class CityDetailsPage extends StatelessWidget {
  final CityModel city;
  const CityDetailsPage({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
            tag: city.assetPath,
            child: SizedBox(
              height: 400,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        height: double.infinity,
                        width: double.infinity,
                        city.assetPath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(26),
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
