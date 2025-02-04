import 'menu_item.dart';

final List<MenuItem> pizzaItems = [
  MenuItem(name: 'Margherita', price: 199, image: 'assets/pizza1.jpg'),
  MenuItem(name: 'Farmhouse', price: 299, image: 'assets/pizza2.jpg'),
];

final List<MenuItem> burgerItems = [
  MenuItem(name: 'Classic Veg', price: 99, image: 'assets/burger1.jpg'),
  MenuItem(name: 'Cheese Burst', price: 129, image: 'assets/burger2.jpg'),
];

final List<MenuItem> chineseItems = [
  MenuItem(name: 'Noodles', price: 149, image: 'assets/chinese1.jpg'),
  MenuItem(name: 'Manchurian', price: 179, image: 'assets/chinese2.jpg'),
];

List<MenuItem> getCategoryItems(int categoryIndex) {
  switch (categoryIndex) {
    case 0: return pizzaItems;
    case 1: return burgerItems;
    case 2: return chineseItems;
    default: return [];
  }
}
