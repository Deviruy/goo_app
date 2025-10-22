import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:goo_app/goo/widgets/city_showcase_widget.dart';
import 'package:provider/provider.dart';

import '../controller/order_provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>().orders;
    return Scaffold(
        body: orders.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/no_orders.png",
                      height: 200,
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'No orders placed yet.\nYour orders appear here',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 40, left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Orders',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: Colors.grey,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Swipe left to cancel your order',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          itemCount: orders.length,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemBuilder: (context, index) {
                            final city = orders[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Slidable(
                                key: ValueKey(city.name),
                                endActionPane: ActionPane(
                                  motion: const DrawerMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (_) {
                                        context
                                            .read<OrderProvider>()
                                            .removeOrder(city);
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Cancel Order',
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/city-details',
                                      arguments: city,
                                    );
                                  },
                                  leading: SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        city.assetPath,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  title: Text(city.name),
                                  subtitle: Text(
                                      'Rating: ${city.rating.toStringAsFixed(1)}'),
                                  trailing: const Icon(Icons.arrow_forward_ios,
                                      size: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(
                                      color: Colors.grey,
                                      width: 0.2,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
