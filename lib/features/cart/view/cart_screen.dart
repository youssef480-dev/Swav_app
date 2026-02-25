import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/cart/cubit/cubit/cart_cubit.dart';
import 'package:graduation_project/features/cart/cubit/cubit/cart_state.dart';
import 'package:graduation_project/features/cart/model/cart_item_model.dart';
import 'package:graduation_project/features/chectout/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.05),
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              final buyItems = state.items
                  .where((item) => item.type == CartItemType.buy)
                  .toList();

              final swapItems = state.items
                  .where((item) => item.type == CartItemType.swap)
                  .toList();

              return Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Cart",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFF355E1B),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ListView(
                        children: [
                          if (buyItems.isNotEmpty) ...[
                            const Text(
                              "Cart Items",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            ...buyItems.map(
                              (item) => buildCartItem(context, item, true),
                            ),
                          ],
                          if (swapItems.isNotEmpty) ...[
                            const SizedBox(height: 20),
                            const Text(
                              "Swap Items",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            ...swapItems.map(
                              (item) => buildCartItem(context, item, false),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Total: \$${state.total.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF4991A),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CheckoutScreen(),
                        ),
                      );
                    },
                    child: const Text("Checkout"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildCartItem(BuildContext context, CartItemModel item, bool isBuy) {
    return Column(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                item.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: const TextStyle(color: Colors.white)),
                  if (isBuy)
                    Text(
                      "\$${item.totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                ],
              ),
            ),
            if (isBuy)
              Row(
                children: [
                  _qtyButton(
                    Icons.remove,
                    () => context.read<CartCubit>().decrementQuantity(item),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      item.quantity.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  _qtyButton(
                    Icons.add,
                    () => context.read<CartCubit>().incrementQuantity(item),
                  ),
                ],
              ),
          ],
        ),
        const Divider(color: Colors.white24)
      ],
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(
          color: Color(0xFFF4991A),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: Colors.white),
      ),
    );
  }
}
