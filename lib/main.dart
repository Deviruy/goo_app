import 'package:flutter/material.dart';
import 'package:goo_app/goo/controller/order_provider.dart';
import 'package:goo_app/goo/models/city_model.dart';
import 'package:provider/provider.dart';
import 'goo/pages/pages.dart';

void main() {
  runApp(
      ChangeNotifierProvider(create: (_) => OrderProvider(), child: MyApp()));
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
