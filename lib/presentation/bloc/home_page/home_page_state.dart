import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class HomePageState extends Equatable {
  final List<String>? categories;
  final List<Product>? menProducts;
  final List<Product>? womenProducts;
  final bool isCategoriesLoading;
  final bool isMenProductsLoading;
  final bool isWomenProductsLoading;
  final Failure? categoryFailure;
  final Failure? menProductsFailure;
  final Failure? womenProductsFailure;

  const HomePageState({
    this.categories,
    this.menProducts,
    this.womenProducts,
    this.isCategoriesLoading = false,
    this.isMenProductsLoading = false,
    this.isWomenProductsLoading = false,
    this.categoryFailure,
    this.menProductsFailure,
    this.womenProductsFailure,
  });

  @override
  List<Object?> get props => [
        categories,
        menProducts,
        womenProducts,
        isCategoriesLoading,
        isMenProductsLoading,
        isWomenProductsLoading,
        categoryFailure,
        menProductsFailure,
        womenProductsFailure,
      ];

  HomePageState copyWith({
    List<String>? categories,
    List<Product>? menProducts,
    List<Product>? womenProducts,
    bool? isCategoriesLoading,
    bool? isMenProductsLoading,
    bool? isWomenProductsLoading,
    Failure? categoryFailure,
    Failure? menProductsFailure,
    Failure? womenProductsFailure,
  }) {
    return HomePageState(
      categories: categories ?? this.categories,
      menProducts: menProducts ?? this.menProducts,
      womenProducts: womenProducts ?? this.womenProducts,
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      isMenProductsLoading: isMenProductsLoading ?? this.isMenProductsLoading,
      isWomenProductsLoading:
          isWomenProductsLoading ?? this.isWomenProductsLoading,
      categoryFailure: categoryFailure ?? this.categoryFailure,
      menProductsFailure: menProductsFailure ?? this.menProductsFailure,
      womenProductsFailure: womenProductsFailure ?? this.womenProductsFailure,
    );
  }
}
