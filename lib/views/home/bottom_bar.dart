import 'package:flutter/material.dart';

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({
    super.key,
  });

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      onPressed: () {},
      label: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            onPressed: () {
              setState(() => _selectedIndex = 0);
            },
            iconSize: _selectedIndex == 0 ? 32.0 : 28.0,
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            icon: Icon(
                _selectedIndex == 0 ? Icons.home_rounded : Icons.home_outlined),
            tooltip: "Home",
          ),
          IconButton(
            onPressed: () {
              setState(() => _selectedIndex = 1);
            },
            iconSize: _selectedIndex == 1 ? 32.0 : 28.0,
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            icon: Icon(_selectedIndex == 1
                ? Icons.shopping_cart_rounded
                : Icons.shopping_cart_outlined),
            tooltip: "Cart",
          ),
          IconButton(
            onPressed: () {
              setState(() => _selectedIndex = 2);
            },
            iconSize: _selectedIndex == 2 ? 32.0 : 28.0,
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            icon: Icon(_selectedIndex == 2
                ? Icons.person_rounded
                : Icons.person_outline),
            tooltip: "Profile",
          ),
        ],
      ),
    );
  }
}
