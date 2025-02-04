import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Pizza', 'count': 5},
    {'name': 'Burgers', 'count': 4},
    {'name': 'Chinese', 'count': 5},
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
      ),
    );
  }
}
