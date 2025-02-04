import 'package:flutter/material.dart';
import 'package:ui_trial_1/combined/screens1/food_item_card.dart';
import 'package:ui_trial_1/combined/screens1/menu_data.dart';
import 'package:ui_trial_1/combined/screens1/menu_item.dart';

class HomeScreen3 extends StatefulWidget {
  @override
  _HomeScreen3State createState() => _HomeScreen3State();
}

class _HomeScreen3State extends State<HomeScreen3>
    with SingleTickerProviderStateMixin {
  int _selectedCategory = 0;
  final List<String> categories = [
    'Pizza',
    'Burgers',
    'Chinese',
    'Pav Bhaji',
    'French Fries',
    'Sandwiches',
    'Frankie'
  ];

  final List<MenuItem> cartItems = [];
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _addToCart(MenuItem item) {
    setState(() {
      cartItems.add(item);
    });
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildCategoryList(),
          Expanded(child: _buildFoodGrid()),
          _buildBottomInfo(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Kingsman Eatery',
          style: TextStyle(fontWeight: FontWeight.bold)),
      actions: [
        IconButton(icon: Icon(Icons.search), onPressed: () {}),
        Stack(
          children: [
            IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(cartItems.length.toString(),
                    style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryList() {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (ctx, index) => GestureDetector(
          onTap: () => setState(() => _selectedCategory = index),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: _selectedCategory == index
                  ? Theme.of(ctx).colorScheme.secondary
                  : Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Text(
              categories[index],
              style: TextStyle(
                color: _selectedCategory == index ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFoodGrid() {
    List<MenuItem> currentItems = getCategoryItems(_selectedCategory);

    return GridView.builder(
      padding: EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: currentItems.length,
      itemBuilder: (ctx, index) => ScaleTransition(
        scale: _animation,
        child: FoodItemCard(
          item: currentItems[index],
          onAdd: () => _addToCart(currentItems[index]),
        ),
      ),
    );
  }

  Widget _buildBottomInfo() {
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Contact: +91 98765 43210',
              style: TextStyle(color: Colors.white)),
          Text('Open: 10 AM - 11 PM', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
