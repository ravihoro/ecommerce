import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class ProductsPageState extends Equatable {
  final List<Product>? products;
  final bool isLoading;
  final Failure? failure;

  const ProductsPageState({
    this.products,
    this.isLoading = false,
    this.failure,
  });

  ProductsPageState copyWith({
    List<Product>? products,
    bool? isLoading,
    Failure? failure,
  }) {
    return ProductsPageState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        products,
        isLoading,
        failure,
      ];
}
