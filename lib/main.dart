import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/Home/cubit/cubit/home_cubit.dart';
import 'package:graduation_project/features/Home/home_screen.dart';
import 'package:graduation_project/features/produt_details/cubit/cubit/cart_counter_cubit.dart';
import 'package:graduation_project/features/cart/cubit/cubit/cart_cubit.dart';
import 'package:graduation_project/features/Swap/cubit/cubit/swap_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (_) => ProductCubit(),
        ),

        BlocProvider(
          create: (_) => HomeCubit()..loadProperties(),
        ),

        BlocProvider(
          create: (_) => CartCubit(),
        ),

        BlocProvider(
          create: (_) => SwapCubit(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}