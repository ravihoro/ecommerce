import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/domain/repositories/favorite_repository.dart';

class RemoveFavoriteUseCase {
  final FavoriteRepository _repository;

  const RemoveFavoriteUseCase(this._repository);

  Future<Either<Failure, bool>> removeFavorite(int id) async {
    return await _repository.removeFavorite(id);
  }
}
