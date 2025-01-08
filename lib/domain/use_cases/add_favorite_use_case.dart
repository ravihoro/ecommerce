import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/repositories/favorite_repository.dart';

class AddFavoriteUseCase {
  final FavoriteRepository _repository;

  const AddFavoriteUseCase(this._repository);

  Future<Either<Failure, bool>> addFavorite(Product product) async {
    return await _repository.addFavorite(product.toProductModel());
  }
}
