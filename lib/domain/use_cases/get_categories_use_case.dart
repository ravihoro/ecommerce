import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/domain/repositories/product_repository.dart';

class GetCategoriesUseCase {
  final ProductRepository _productRepository;

  const GetCategoriesUseCase(this._productRepository);

  Future<Either<Failure, List<String>>> getCategories() async {
    return await _productRepository.getCategories();
  }
}
