import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/Home/cubit/cubit/home_cubit.dart';
import 'package:graduation_project/features/Home/cubit/cubit/home_state.dart';
import 'package:graduation_project/features/addingItems/add_item.dart';
import 'package:graduation_project/features/cart/cubit/cubit/cart_cubit.dart';
import 'package:graduation_project/features/cart/cubit/cubit/cart_state.dart';
import 'package:graduation_project/features/cart/model/cart_item_model.dart';
import 'package:graduation_project/features/cart/view/cart_screen.dart';
import 'package:graduation_project/features/produt_details/details_screen.dart';
import 'package:graduation_project/features/Swap/cubit/cubit/swap_cubit.dart';
import 'package:graduation_project/features/Swap/model/SwapRequestModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: height * 0.05,
            ),
            const Text(
              "Swav",
              style: TextStyle(
                  color: Color(0xFFF4991A), fontWeight: FontWeight.w200),
            ),
          ],
        ),
        actions: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              int itemCount =
                  state.items.fold(0, (prev, item) => prev + item.quantity);

              return Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CartScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart_outlined,
                        color: Color(0xFFF4991A)),
                  ),
                  if (itemCount > 0)
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "$itemCount",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.02),
              Row(
                children: [
                  Icon(Icons.notifications_none_outlined, size: height * 0.03),
                  const Spacer(),
                  const Icon(Icons.location_on, color: Color(0xFFF4991A)),
                  SizedBox(width: width * 0.01),
                  const Text(
                    "Egypt",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
              SizedBox(height: height * 0.03),
              Container(
                height: height * 0.06,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    SizedBox(width: width * 0.03),
                    const Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: width * 0.02),
                    const Text(
                      "Search...",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Icon(Icons.filter_list_outlined,
                          color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.04),
              const Row(
                children: [
                  Text(
                    "Explore categories",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    "See All",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildCategory(Icons.home, "Real Estate", height),
                  buildCategory(Icons.directions_car, "Cars", height),
                  buildCategory(Icons.phone_android, "Mobiles", height),
                  buildCategory(Icons.work, "Electronics", height),
                ],
              ),
              SizedBox(height: height * 0.04),
              const Row(
                children: [
                  Text(
                    "Real Estates",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    "See All",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: height * 0.02),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoaded) {
                    return SizedBox(
                      height: height * 0.45,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.properties.length,
                        itemBuilder: (context, index) {
                          final property = state.properties[index];
                          return buildPropertyCard(property, width, height);
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFF4991A),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xFFF4991A),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });

          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const UploadItemScreen(),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline), label: "Chats"),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 35, color: Color(0xFFF4991A)),
            label: "Sell",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: "Settings"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Account"),
        ],
      ),
    );
  }

  Widget buildCategory(IconData icon, String text, double height) {
    return Column(
      children: [
        CircleAvatar(
          radius: height * 0.035,
          backgroundColor: Colors.grey[200],
          child: Icon(icon, color: const Color(0xFFF4991A)),
        ),
        const SizedBox(height: 6),
        Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget buildPropertyCard(property, double width, double height) {
    return Container(
      width: width * 0.6,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailsScreen(property: property),
                ),
              );
            },
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                property.image,
                height: height * 0.18,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.favorite_border, size: 18),
                    const Spacer(),
                    Text(property.price,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 5),
                Text(property.title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(property.details,
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
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
                                      .replaceAll(RegExp(r'[^0-9.]'), '')),
                                  type: CartItemType.buy,
                                ),
                              );
                        },
                        child: const Text("Add to Cart"),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFF4991A)),
                        ),
                        onPressed: () {
                          final TextEditingController messageController =
                              TextEditingController();

                          showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "Choose product to swap with",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 15),
                                    ListTile(
                                      title: const Text("My item"),
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
                                                message: messageController.text,
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
                                        hintText: "Write a message (optional)",
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
    );
  }
}
