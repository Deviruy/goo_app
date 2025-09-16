import 'package:flutter/material.dart';
import 'package:goo_app/goo/models/city_model.dart';
import 'package:goo_app/goo/repository/city_repository.dart';

import '../widgets/home_header_widget.dart';

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

            final popularCities = cities.where((c) => c.rating > 4.7).toList();
            final recommendedCities =
                cities.where((c) => c.rating <= 4.7).toList();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  const HomeHeaderWidget(),
                  const SizedBox(height: 28),

                  // Search
                  HomeSearchWidget(),

                  // Popular cities section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 16),
                                width: 220,
                                height: 240,
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.black.withValues(alpha: 0.3),
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
                                      popularCities[index].assetPath,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 16, bottom: 56),
                                      child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.grey
                                                .withValues(alpha: .7),
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 18),
                                          child: Text(
                                            popularCities[index].name,
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
                                            color: Colors.grey
                                                .withValues(alpha: .7),
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 12),
                                          child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                  size: 18,
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Text(
                                                  popularCities[index]
                                                      .rating
                                                      .toString(),
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
                                ]),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        padding: EdgeInsets.only(
                            bottom: 22, left: 16, right: 16, top: 8),
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.3,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: List.generate(
                            recommendedCities.length,
                            (index) => Container(
                              height: 1,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: .7),
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.black.withValues(alpha: 0.3),
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
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: Image.asset(
                                            recommendedCities[index].assetPath,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 16, bottom: 8),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        recommendedCities[index].name,
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
                                      padding: EdgeInsets.only(
                                          bottom: 20, right: 15),
                                      child: Container(
                                        padding: EdgeInsets.all(3),
                                        height: 30,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.white
                                                .withValues(alpha: .6),
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade700,
                                            borderRadius:
                                                BorderRadius.circular(25),
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
                                                    recommendedCities[index]
                                                        .rating
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                          ),
                        ),
                      )
                    ],
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

class HomeSearchWidget extends StatelessWidget {
  const HomeSearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Icon(
              Icons.search,
              size: 30,
              color: Colors.grey,
            ),
            const SizedBox(width: 6),
            const Expanded(
              child: TextField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: 'Find things to do',
                  border: InputBorder.none,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
