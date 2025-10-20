import 'package:flutter/material.dart';

class HomeSearchWidget extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const HomeSearchWidget({
    super.key,
    required this.onChanged,
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
            Expanded(
              child: TextField(
                onChanged: onChanged,
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
