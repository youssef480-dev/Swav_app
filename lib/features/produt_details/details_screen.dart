import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/Home/models/property_model.dart';
import 'package:graduation_project/features/Swap/cubit/cubit/swap_cubit.dart';
import 'package:graduation_project/features/Swap/model/SwapRequestModel.dart';
import 'package:graduation_project/features/cart/cubit/cubit/cart_cubit.dart';
import 'package:graduation_project/features/cart/model/cart_item_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final PropertyModel property;

  const ProductDetailsScreen({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              property.image,
              height: height * 0.3,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(property.price,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(property.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(property.details,
                      style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF4991A),
                          ),
                          onPressed: () {
                            context.read<CartCubit>().addItem(
                                  CartItemModel(
                                    name: property.title,
                                    image: property.image,
                                    price: double.parse(property.price
                                        .replaceAll(RegExp(r'[^0-9]'), '')),
                                    type: CartItemType.buy,
                                  ),
                                );
                          },
                          child: const Text("Add to Cart"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFF4991A)),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (_) {
                                final TextEditingController messageController =
                                    TextEditingController();

                                return Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text("Choose product to swap with",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 15),
                                      ListTile(
                                        title: const Text("My Old Laptop"),
                                        onTap: () {
                                          context.read<CartCubit>().addItem(
                                                CartItemModel(
                                                  name: property.title,
                                                  image: property.image,
                                                  price: 0, 
                                                  type: CartItemType.swap,
                                                ),
                                              );

                                          context
                                              .read<SwapCubit>()
                                              .sendSwapRequest(
                                                SwapRequestModel(
                                                  requestedProductName:
                                                      property.title,
                                                  offeredProductName:
                                                      "My Old Laptop",
                                                  ownerName: "Yousef",
                                                  message:
                                                      messageController.text,
                                                ),
                                              );

                                          Navigator.pop(context);

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text("Added to Swap Cart")),
                                          );
                                        },
                                      ),
                                      TextField(
                                        controller: messageController,
                                        decoration: const InputDecoration(
                                          hintText:
                                              "Write a message (optional)",
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text(
                            "Swap",
                            style: TextStyle(color: Color(0xFFF4991A)),
                          ),
                        ),
                      ),
                    ],
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
