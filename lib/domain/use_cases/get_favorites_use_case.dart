import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/repositories/favorite_repository.dart';

class GetFavoritesUseCase {
  final FavoriteRepository _repository;

  const GetFavoritesUseCase(this._repository);

  Future<Either<Failure, List<Product>>> getFavorites() async {
    var either = await _repository.getFavorites();
    return either.fold(
      (l) => Left(l),
      (r) => Right(
        [for (final p in r) Product.fromModel(p)],
      ),
    );
  }
}
