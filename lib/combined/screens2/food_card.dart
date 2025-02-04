import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String name;
  final int price;
  final String image;
  final String ingredients;

  FoodCard({
    required this.name,
    required this.price,
    required this.image,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  image,
                  height: 190,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Item Name
                    Text(
                      name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),

                    // Ingredients (with ellipsis)
                    Text(
                      _truncateText(
                          ingredients, 30), // Limiting to 30 characters
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),

                    SizedBox(height: 6),

                    // Price & Add-to-Cart Button in a Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹$price',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                        IconButton(
                          icon: Icon(Icons.add_circle,
                              color: Theme.of(context).primaryColor, size: 28),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Favorite Icon on Top Right
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                // with opacity works :)
                color: Colors.white.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.favorite_border, color: Colors.red),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to limit text length and add ellipsis
  String _truncateText(String text, int maxLength) {
    return (text.length > maxLength)
        ? '${text.substring(0, maxLength)}...'
        : text;
  }
}
