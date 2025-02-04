import 'package:flutter/material.dart';
import 'package:ui_trial_1/combined/screens2/cart_page.dart';
import 'package:ui_trial_1/combined/screens2/home_page.dart';
import 'package:ui_trial_1/combined/screens2/menu_page.dart';
import 'package:ui_trial_1/combined/startup_pages/profile_page.dart';

class HomeScreen4 extends StatefulWidget {
  @override
  _HomeScreen4State createState() => _HomeScreen4State();
}

class _HomeScreen4State extends State<HomeScreen4> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    MenuPage(),
    CartPage(),
    // OrdersPage(),
    // ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/logo.png', height: 40),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              }),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
        ],
      ),
    );
  }
}
