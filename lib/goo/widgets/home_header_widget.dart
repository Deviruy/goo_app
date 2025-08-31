import 'package:flutter/material.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Explore',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w300),
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: 18,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  'Europe',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.blue,
                )
              ],
            ),
          ],
        ),
        Text(
          'Europe',
          style: TextStyle(
              fontSize: 28,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              height: .9),
        ),
      ],
    );
  }
}
