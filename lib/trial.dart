import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Kingsman Eatery',
//       theme: ThemeData(
//         primaryColor: Colors.orange[800],
//         secondaryHeaderColor: Colors.green,
//         //accentColor: Colors.amber,
//         fontFamily: 'Poppins',
//         appBarTheme: AppBarTheme(
//           color: Colors.white,
//           elevation: 2,
//           iconTheme: IconThemeData(color: Colors.black),
//         ),
//       ),
//       home: HomeScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// *******************************************************
// keep nav bar (check for last 2 options)
// HOME :
// remove search
// keep popular items (horizontal) - layout -> previous one
// change category to previous category selection
// vertical list view (items) - previous one
//
// MENU :
// to choose: drop down selection OR new page (same way to display item)
//
// CART:
// change TOTAL to RECT BOX with payment summary (all charges)
// when empty cart , display EMPTY
// *******************************************************

class HomeScreen1 extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen1> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    MenuPage(),
    CartPage(),
    //OrdersPage(),
    //ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.png', height: 40),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
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
          BottomNavigationBarItem(
              icon: Icon(Icons.track_changes), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          Text('Popular Items',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => FoodCard(),
            ),
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 10,
            children: [
              FilterChip(label: Text('Pizza'), onSelected: (_) {}),
              FilterChip(label: Text('Burgers'), onSelected: (_) {}),
              FilterChip(label: Text('Chinese'), onSelected: (_) {}),
            ],
          ),
        ],
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset('assets/pizza.png',
                  height: 120, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Margherita Pizza',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('₹199', style: TextStyle(color: Colors.green)),
                  SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {},
                    child: Text('Add to Cart'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Pizza', 'count': 5},
    {'name': 'Burgers', 'count': 4},
    {'name': 'Chinese', 'count': 5},
    // Add other categories
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16),
      itemCount: categories.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.fastfood, color: Theme.of(context).primaryColor),
        title: Text(categories[index]['name']),
        subtitle: Text('${categories[index]['count']} items'),
        trailing: Icon(Icons.chevron_right),
        //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryItemsPage())),
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) => ListTile(
              leading: Image.asset('assets/pizza.png', width: 50),
              title: Text('Margherita Pizza'),
              subtitle: Text('₹199 x $_quantity'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () => setState(
                        () => _quantity = _quantity > 1 ? _quantity - 1 : 1),
                  ),
                  Text('$_quantity'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => setState(() => _quantity++),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('₹597', style: TextStyle(fontSize: 18, color: Colors.green)),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          ),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => CheckoutPage())),
          child: Text('Proceed to Checkout'),
        ),
      ],
    );
  }
}

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkout')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Delivery Address'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Payment Details'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Delivery Time'),
                items: ['ASAP', '30 mins', '1 hour']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (_) {},
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text('Place Order'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Add remaining pages (OrdersPage, ProfilePage, CategoryItemsPage) similarly
