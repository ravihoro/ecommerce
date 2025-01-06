import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/repositories/product_repository.dart';

class GetAllProductsUseCase {
  final ProductRepository _productRepository;

  const GetAllProductsUseCase(this._productRepository);

  Future<Either<Failure, List<Product>>> getAllProducts() async {
    var result = await _productRepository.getAllProducts();
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
