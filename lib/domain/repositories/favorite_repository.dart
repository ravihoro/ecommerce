import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/data/models/product_model.dart';

abstract class FavoriteRepository {
  Future<Either<Failure, bool>> addFavorite(ProductModel product);
  Future<Either<Failure, bool>> removeFavorite(int id);
  Future<Either<Failure, List<ProductModel>>> getFavorites();
}
