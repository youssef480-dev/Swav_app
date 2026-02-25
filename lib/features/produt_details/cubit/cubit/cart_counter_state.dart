import 'package:equatable/equatable.dart';

class ProductState extends Equatable {
  final int cartCount;
  final bool isFavorite;

  const ProductState({
    this.cartCount = 0,
    this.isFavorite = false,
  });

  ProductState copyWith({
    int? cartCount,
    bool? isFavorite,
  }) {
    return ProductState(
      cartCount: cartCount ?? this.cartCount,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object> get props => [cartCount, isFavorite];
}
