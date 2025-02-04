import 'package:flutter/material.dart';
import 'menu_item.dart';

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
                // Text(item.name, style: Theme.of(context).textTheme.bodyText2),
                Text(item.name,), // removed above line (to fix)
                SizedBox(height: 4),
                Text('₹${item.price}', style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                )),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.add_circle, color: Theme.of(context).colorScheme.secondary),
                    onPressed: () => onAdd(),
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
