import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/repositories/product_repository.dart';

class GetProductsByCategoryUseCase {
  final ProductRepository _productRepository;

  const GetProductsByCategoryUseCase(this._productRepository);

  Future<Either<Failure, List<Product>>> getProductsByCategory(
      String category) async {
    var result = await _productRepository.getProductsByCategory(category);
    return result.fold(
      (l) => Left(l),
      (r) => Right(
        [
          for (final product in r) Product.fromModel(product),
        ],
      ),
    );
  }
}
