import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/exceptions.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/data/data_source/favorite_data_source.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteDataSource dataSource;

  const FavoriteRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, bool>> addFavorite(ProductModel product) async {
    try {
      await dataSource.addFavorite(product);
      return Right(true);
    } on DatabaseInsertException catch (e) {
      return Left(DatabaseInsertFailure(e.message));
    } catch (e) {
      return Left(CustomFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getFavorites() async {
    try {
      var response = await dataSource.getFavorites();
      return Right(response);
    } on DatabaseFetchException catch (e) {
      return Left(DatabaseFetchFailure(e.message));
    } catch (e) {
      return Left(CustomFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> removeFavorite(int id) async {
    try {
      await dataSource.removeFavorite(id);
      return Right(true);
    } on DatabaseDeleteException catch (e) {
      return Left(DatabaseDeleteFailure(e.message));
    } catch (e) {
      return Left(CustomFailure(e.toString()));
    }
  }
}
