import 'package:ecommerce/core/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/models/product_model.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<String>>> getCategories();

  Future<Either<Failure, List<ProductModel>>> getAllProducts();

  Future<Either<Failure, List<ProductModel>>> getProductsByCategory(
      String category);
}
