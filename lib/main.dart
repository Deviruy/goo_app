import 'package:flutter/material.dart';
import 'package:goo_app/goo/models/city_model.dart';
import 'package:goo_app/goo/pages/city_details_page.dart';

import 'goo/pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Goo App',
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const OnboardingPage());
          case '/home':
            return MaterialPageRoute(builder: (_) => const HomePage());
          case '/city-details':
            final args = settings.arguments as CityModel;
            return MaterialPageRoute(
              builder: (_) => CityDetailsPage(city: args),
            );
        }
        return null;
      },
    );
  }
}
