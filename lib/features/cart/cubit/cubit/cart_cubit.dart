import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/cart/model/cart_item_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState());
  void addItem(CartItemModel item) {
    final existingIndex = state.items
        .indexWhere((i) => i.name == item.name && i.type == item.type);

    List<CartItemModel> updatedItems = List.from(state.items);

    if (existingIndex != -1) {
      if (item.type == CartItemType.buy) {
        updatedItems[existingIndex].quantity += item.quantity;
      }
    } else {
      updatedItems.add(item);
    }

    emit(CartState(items: updatedItems));
  }

  void removeItem(CartItemModel item) {
    final updatedItems = List<CartItemModel>.from(state.items)..remove(item);
    emit(CartState(items: updatedItems));
  }

  void incrementQuantity(CartItemModel item) {
    final index = state.items
        .indexWhere((i) => i.name == item.name && i.type == item.type);
    if (index != -1) {
      final updatedItems = List<CartItemModel>.from(state.items);
      updatedItems[index].quantity++;
      emit(CartState(items: updatedItems));
    }
  }

  void decrementQuantity(CartItemModel item) {
    final index = state.items
        .indexWhere((i) => i.name == item.name && i.type == item.type);
    if (index != -1 && state.items[index].quantity > 1) {
      final updatedItems = List<CartItemModel>.from(state.items);
      updatedItems[index].quantity--;
      emit(CartState(items: updatedItems));
    }
  }
}
