import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/order_provider.dart';
import 'pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  final List<Widget> _pages = const [HomePage(), OrdersPage()];

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.read<OrderProvider>().currentIndex;
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // Animated pages
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            transitionBuilder: (child, animation) {
              final inFromRight = currentIndex == 1;
              final offsetAnimation = Tween<Offset>(
                begin: Offset(inFromRight ? 1.0 : -1.0, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              ));

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
            child: KeyedSubtree(
              key: ValueKey<int>(context.watch<OrderProvider>().currentIndex),
              child: _pages[currentIndex],
            ),
          ),

          // Bottom Navigation
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 65,
                width: 230,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _NavItem(
                      icon: Icons.public,
                      label: 'Home',
                      isSelected: currentIndex == 0,
                      onTap: () => setState(() =>
                          context.read<OrderProvider>().changeIndexPage(0)),
                    ),
                    _NavItem(
                      icon: Icons.airplanemode_active,
                      isReversed: true,
                      label: 'Orders',
                      isSelected: currentIndex == 1,
                      onTap: () => setState(() =>
                          context.read<OrderProvider>().changeIndexPage(1)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isReversed;

  const _NavItem(
      {required this.icon,
      required this.label,
      required this.isSelected,
      required this.onTap,
      this.isReversed = false});

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Colors.deepPurple : Colors.grey;

    Widget buildAnimatedIcon(Color color) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        child: Icon(
          icon,
          color: color,
          size: isSelected ? 28 : 24,
        ),
      );
    }

    Widget buildAnimatedText(Color color) {
      return AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        child: isSelected
            ? Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              )
            : const SizedBox(),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.deepPurple.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: isReversed
              ? [
                  buildAnimatedText(color),
                  const SizedBox(width: 6),
                  buildAnimatedIcon(color),
                ]
              : [
                  buildAnimatedIcon(color),
                  const SizedBox(width: 6),
                  buildAnimatedText(color),
                ],
        ),
      ),
    );
  }
}
