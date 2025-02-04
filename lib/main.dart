import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ui_trial_1/combined/auth/auth_gate.dart';
import 'package:ui_trial_1/combined/main_screen2.dart';


void main() async{

  // supabase setup
  await Supabase.initialize(
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImttY2NxZ210Y2xkcW5ja2thYWFyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgxMzY2OTYsImV4cCI6MjA1MzcxMjY5Nn0.ufyZzzpTw07SqYQ-CnX1xF6BcZ3IxGCOQAzRapcLOOY",
    url: "https://kmccqgmtcldqnckkaaar.supabase.co",
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kingsman Eatery',
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: 'Roboto',
      ),
      home: AuthGate(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<String> categories = ["Pizza", "Burgers", "Chinese", "Pav Bhaji"];
  final List<String> carouselImages = [
    "assets/deal1.jpg",
    "assets/deal2.jpg",
    "assets/deal3.jpg"
  ];

  final List<Map<String, String>> foodItems = [
    {"name": "Cheese Pizza", "image": "assets/pizza.jpg", "price": "\$12"},
    {"name": "Chicken Burger", "image": "assets/burger.jpg", "price": "\$10"},
    {"name": "Hakka Noodles", "image": "assets/noodles.jpg", "price": "\$8"},
    {"name": "Pav Bhaji", "image": "assets/pavbhaji.jpg", "price": "\$6"},
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Kingsman Eatery", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              // Cart action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categories
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Chip(
                      label: Text(categories[index]),
                      backgroundColor: Colors.redAccent,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),

            // Carousel Slider
            CarouselSlider(
              options: CarouselOptions(
                height: 180.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: carouselImages.map((image) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 10),

            // Popular Food List
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Popular Dishes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),

            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: foodItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                          child: Image.asset(foodItems[index]["image"]!, fit: BoxFit.cover, width: double.infinity),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(foodItems[index]["name"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(foodItems[index]["price"]!, style: TextStyle(color: Colors.red)),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: Text("Add to Cart"),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}