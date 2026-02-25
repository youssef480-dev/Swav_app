
import 'package:graduation_project/features/cart/model/cart_item_model.dart';

class CartState {
  final List<CartItemModel> items;

  CartState({this.items = const []});

  double get total {
    double sum = 0;
    for (var item in items) {
      if (item.type == CartItemType.buy) {
        sum += item.totalPrice;
      }
    }
    return sum;
  }
}