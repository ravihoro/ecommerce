import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/repositories/product_repository.dart';

class GetProductByIdUseCase {
  final ProductRepository _repository;

  const GetProductByIdUseCase(this._repository);

  Future<Either<Failure, Product>> getProductById(int id) async {
    var either = await _repository.getProductById(id);
    return either.fold((l) => Left(l), (r) => Right(Product.fromModel(r)));
  }
}
