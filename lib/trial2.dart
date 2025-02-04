import 'package:flutter/material.dart';
// import 'package:flutter/animation.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Kingsman Eatery',
//       theme: ThemeData(
//         primaryColor: Color(0xFFD32F2F),
//         accentColor: Color(0xFFFFA000),
//         fontFamily: 'Poppins',
//         textTheme: TextTheme(
//           headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           bodyText2: TextStyle(fontSize: 16),
//         ),
//       ),
//       home: HomeScreen(),
//     );
//   }
// }


// *******************************************************
// keep the horizontal vist view (of category as it) , will add icons there 
// keep the verticle list view (of items in each category)
// remove snackbar and appbar
// *******************************************************


class HomeScreen2 extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen2> with SingleTickerProviderStateMixin {
  int _selectedCategory = 0;
  final List<String> categories = [
    'Pizza', 'Burgers', 'Chinese', 'Pav Bhaji',
    'French Fries', 'Sandwiches', 'Frankie'
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
      title: Text('Kingsman Eatery', style: TextStyle(fontWeight: FontWeight.bold)),
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
                child: Text(cartItems.length.toString(), style: TextStyle(color: Colors.white)),
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
    List<MenuItem> currentItems = [];
    switch (_selectedCategory) {
      case 0: currentItems = pizzaItems; break;
      case 1: currentItems = burgerItems; break;
      case 2: currentItems = chineseItems; break;
      case 3: currentItems = pavBhajiItems; break;
      case 4: currentItems = frenchFriesItems; break;
      case 5: currentItems = sandwichItems; break;
      case 6: currentItems = frankieItems; break;
    }

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
          Text('Contact: +91 98765 43210', style: TextStyle(color: Colors.white)),
          Text('Open: 10 AM - 11 PM', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

class FoodItemCard extends StatelessWidget {
  final MenuItem item;
  final Function onAdd;

  const FoodItemCard({Key? key, required this.item, required this.onAdd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                item.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: Theme.of(context).textTheme.bodyText2),
                SizedBox(height: 4),
                Text('₹${item.price}', style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                )),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.add_circle, color: Theme.of(context).accentColor),
                    // onPressed: onAdd,
                    onPressed: () {
                      //
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension on TextTheme {
  get bodyText2 => TextStyle(fontSize: 16);
}

extension on ThemeData {
  get accentColor => Color(0xFFFFA000);
}

class MenuItem {
  final String name;
  final double price;
  final String image;

  MenuItem({required this.name, required this.price, required this.image});
}

// Sample Data
final List<MenuItem> pizzaItems = [
  MenuItem(name: 'Margherita', price: 199, image: 'assets/pizza1.jpg'),
  MenuItem(name: 'Farmhouse', price: 299, image: 'assets/pizza2.jpg'),
  MenuItem(name: 'Paneer Tikka', price: 249, image: 'assets/pizza3.jpg'),
  MenuItem(name: 'Veg Supreme', price: 349, image: 'assets/pizza4.jpg'),
  MenuItem(name: 'Golden Corn', price: 229, image: 'assets/pizza5.jpg'),
];

final List<MenuItem> burgerItems = [
  MenuItem(name: 'Classic Veg', price: 99, image: 'assets/burger1.jpg'),
  MenuItem(name: 'Cheese Burst', price: 129, image: 'assets/burger2.jpg'),
  MenuItem(name: 'Aloo Tikki', price: 79, image: 'assets/burger3.jpg'),
  MenuItem(name: 'Mexican Burger', price: 149, image: 'assets/burger4.jpg'),
];

final List<MenuItem> frankieItems = [
  MenuItem(name: 'Margherita', price: 199, image: 'assets/pizza1.jpg'),
  MenuItem(name: 'Farmhouse', price: 299, image: 'assets/pizza2.jpg'),
  MenuItem(name: 'Paneer Tikka', price: 249, image: 'assets/pizza3.jpg'),
  MenuItem(name: 'Veg Supreme', price: 349, image: 'assets/pizza4.jpg'),
  MenuItem(name: 'Golden Corn', price: 229, image: 'assets/pizza5.jpg'),
];

final List<MenuItem> sandwichItems = [
  MenuItem(name: 'Classic Veg', price: 99, image: 'assets/burger1.jpg'),
  MenuItem(name: 'Cheese Burst', price: 129, image: 'assets/burger2.jpg'),
  MenuItem(name: 'Aloo Tikki', price: 79, image: 'assets/burger3.jpg'),
  MenuItem(name: 'Mexican Burger', price: 149, image: 'assets/burger4.jpg'),
];

final List<MenuItem> frenchFriesItems = [
  MenuItem(name: 'Margherita', price: 199, image: 'assets/pizza1.jpg'),
  MenuItem(name: 'Farmhouse', price: 299, image: 'assets/pizza2.jpg'),
  MenuItem(name: 'Paneer Tikka', price: 249, image: 'assets/pizza3.jpg'),
  MenuItem(name: 'Veg Supreme', price: 349, image: 'assets/pizza4.jpg'),
  MenuItem(name: 'Golden Corn', price: 229, image: 'assets/pizza5.jpg'),
];

final List<MenuItem> pavBhajiItems = [
  MenuItem(name: 'Classic Veg', price: 99, image: 'assets/burger1.jpg'),
  MenuItem(name: 'Cheese Burst', price: 129, image: 'assets/burger2.jpg'),
  MenuItem(name: 'Aloo Tikki', price: 79, image: 'assets/burger3.jpg'),
  MenuItem(name: 'Mexican Burger', price: 149, image: 'assets/burger4.jpg'),
];

final List<MenuItem> chineseItems = [
  MenuItem(name: 'Classic Veg', price: 99, image: 'assets/burger1.jpg'),
  MenuItem(name: 'Cheese Burst', price: 129, image: 'assets/burger2.jpg'),
  MenuItem(name: 'Aloo Tikki', price: 79, image: 'assets/burger3.jpg'),
  MenuItem(name: 'Mexican Burger', price: 149, image: 'assets/burger4.jpg'),
];

// Add similar lists for other categories...