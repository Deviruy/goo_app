import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage('assets/images/onboarding-background.jpg'),
                    fit: BoxFit.cover),
              )),
          Padding(
            padding: EdgeInsets.only(top: 60, bottom: 45, left: 20, right: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Goo',
                    style: TextStyle(
                      fontFamily: 'Damion',
                      fontSize: 150,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Plan your',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            Text(
                              'Luxurious',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  height: .9),
                            ),
                            Text(
                              'Vacation',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  height: .9),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomButton(
                        buttonTittle: 'Explore',
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/main');
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String buttonTittle;
  final VoidCallback onTap;
  final double height;
  final FontWeight? fontWeight;
  const CustomButton({
    super.key,
    required this.buttonTittle,
    required this.onTap,
    this.height = 55,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              buttonTittle,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: fontWeight ?? FontWeight.w500),
            ),
          ]),
        ),
      ),
    );
  }
}
