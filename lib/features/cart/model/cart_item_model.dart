enum CartItemType { buy, swap }

class CartItemModel {
  final String name;
  final String image;
  final double price;
  final CartItemType type;
  int quantity;

  CartItemModel({
    required this.name,
    required this.image,
    required this.price,
    required this.type,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;
}