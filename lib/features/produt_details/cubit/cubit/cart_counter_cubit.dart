import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/produt_details/model/productdetails_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductUpdated extends ProductState {}

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  final List<ProductModel> cartItems = [];

  void addToCart(ProductModel product) {
    cartItems.add(product);
    emit(ProductUpdated());
  }

  void removeFromCart(ProductModel product) {
    cartItems.remove(product);
    emit(ProductUpdated());
  }
}