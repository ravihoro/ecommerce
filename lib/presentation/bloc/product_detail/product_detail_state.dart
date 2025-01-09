import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class ProductDetailState extends Equatable {
  final Product? product;
  final bool isLoading;
  final Failure? failure;

  const ProductDetailState({
    this.product,
    this.isLoading = true,
    this.failure,
  });

  ProductDetailState copyWith({
    Product? product,
    bool? isLoading,
    Failure? failure,
  }) {
    return ProductDetailState(
      product: product ?? this.product,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        product,
        isLoading,
        failure,
      ];
}
