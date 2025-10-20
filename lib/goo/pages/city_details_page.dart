import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:goo_app/goo/controller/order_provider.dart';
import 'package:goo_app/goo/models/city_model.dart';
import 'package:goo_app/goo/widgets/facility_item.dart';
import 'package:provider/provider.dart';

class CityDetailsPage extends StatefulWidget {
  final CityModel city;
  const CityDetailsPage({super.key, required this.city});

  @override
  State<CityDetailsPage> createState() => _CityDetailsPageState();
}

class _CityDetailsPageState extends State<CityDetailsPage> {
  bool isExpanded = false;
  bool showReadMore = true;

  @override
  Widget build(BuildContext context) {
    final isAlreadyOrdered =
        context.read<OrderProvider>().isAlreadyOrdered(widget.city);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SafeArea(
              child: Hero(
                  tag: widget.city.assetPath,
                  child: SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset(
                              height: double.infinity,
                              width: double.infinity,
                              widget.city.assetPath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(26),
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                size: 18,
                                color: Colors.grey.withValues(alpha: 5),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.city.name,
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Show map',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ]),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow.shade900,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(widget.city.rating.toString(),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey)),
                const SizedBox(
                  width: 4,
                ),
                Text('(${widget.city.reviews.toString()}) Reviews',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey)),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: isExpanded ? null : 80,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.city.description,
                  softWrap: true,
                  maxLines: isExpanded ? 30 : 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            if (!isExpanded && showReadMore)
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = true;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      'Read more',
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w700),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.blue,
                    )
                  ],
                ),
              ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Facilities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 12,
              runSpacing: 12,
              children: widget.city.facilites.map((facility) {
                return FacilityItem(facilityItem: facility);
              }).toList(),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '\$${widget.city.price.toInt().toString()}',
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.lightGreen,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    context.read<OrderProvider>().addOrder(widget.city);
                    Navigator.pop(context);
                    Flushbar(
                      message: "✈️ Your trip has been booked!",
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.green.shade400,
                      margin: const EdgeInsets.all(8),
                      borderRadius: BorderRadius.circular(8),
                      flushbarPosition: FlushbarPosition.TOP,
                    ).show(context);
                  },
                  child: Container(
                    height: 65,
                    width: MediaQuery.of(context).size.width * .6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue.shade600),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isAlreadyOrdered ? 'See order' : 'Book now',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            )
          ]),
        ),
      ),
    );
  }
}
