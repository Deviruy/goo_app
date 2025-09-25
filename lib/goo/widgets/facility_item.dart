import 'package:flutter/material.dart';
import 'package:goo_app/goo/models/city_model.dart';

class FacilityItem extends StatelessWidget {
  final FacilitiesModel facilityItem;
  const FacilityItem({super.key, required this.facilityItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: .05),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: .6,
            child: Image.asset(
              facilityItem.iconPath,
              width: 35,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            '${facilityItem.quantity ?? ''} ${facilityItem.name}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
