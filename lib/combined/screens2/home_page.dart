import 'package:flutter/material.dart';
import 'package:ui_trial_1/combined/screens2/food_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = "All"; // Default category

  final List<Map<String, String>> categories = [
    {"name": "All", "icon": "assets/all.png"},
    {"name": "Pizza", "icon": "images/pizza.png"},
    {"name": "Burgers", "icon": "images/burger.png"},
    {"name": "Chinese", "icon": "assets/chinese_icon.png"},
    {"name": "Pav Bhaji", "icon": "assets/pavbhaji_icon.png"},
    {"name": "Frankies", "icon": "assets/frankie_icon.png"},
  ];

  final List<Map<String, dynamic>> foodItems = [
    {
      "name": "Margherita Pizza",
      "category": "Pizza",
      "price": 199,
      "image": "images/pizza.png"
    },
    {
      "name": "Cheese Burger",
      "category": "Burgers",
      "price": 149,
      "image": "images/burger.png"
    },
    {
      "name": "Paneer Frankie",
      "category": "Frankies",
      "price": 129,
      "image": "assets/frankie.png"
    },
    {
      "name": "Manchurian",
      "category": "Chinese",
      "price": 159,
      "image": "assets/chinese.png"
    },
    {
      "name": "Pav Bhaji",
      "category": "Pav Bhaji",
      "price": 99,
      "image": "assets/pavbhaji.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredItems = _selectedCategory == "All"
        ? foodItems
        : foodItems
            .where((item) => item["category"] == _selectedCategory)
            .toList();

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search food...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),

          // Horizontal Category Selector with Icons
          Container(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = categories[index]["name"]!;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: _selectedCategory == categories[index]["name"]
                          ? Theme.of(context).primaryColor
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (categories[index]["name"] !=
                            "All") // Skip icon for "All"
                          Image.asset(
                            categories[index]["icon"]!,
                            height: 24,
                            width: 24,
                            fit: BoxFit.cover,
                          ),
                        SizedBox(
                            width: categories[index]["name"] != "All"
                                ? 8
                                : 0), // Space only if icon exists
                        Text(
                          categories[index]["name"]!,
                          style: TextStyle(
                            color:
                                _selectedCategory == categories[index]["name"]
                                    ? Colors.white
                                    : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 20),
          Text('Food Items',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),

          // Display Items in Grid
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 items per row
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75, // Adjust height-to-width ratio
            ),
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              return FoodCard(
                name: filteredItems[index]["name"],
                price: filteredItems[index]["price"],
                image: filteredItems[index]["image"],
                ingredients:
                    "Tomato, Cheese, Basil, Olive Oil, Garlic, Oregano",
              );
            },
          ),
        ],
      ),
    );
  }
}
