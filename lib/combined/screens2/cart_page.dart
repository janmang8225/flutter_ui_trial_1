import 'package:flutter/material.dart';
import 'checkout_page.dart';

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
