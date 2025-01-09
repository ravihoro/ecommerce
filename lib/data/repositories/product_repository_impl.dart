import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/core/helper_functions.dart';
import 'package:ecommerce/data/data_source/product_data_source.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource _dataSource;

  const ProductRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProducts() async {
    return await getRepositoryCall<List<ProductModel>,
        List<Map<String, dynamic>>>(
      _dataSource.getAllProducts,
      (json) => [for (final r in json) ProductModel.fromJson(r)],
    );
  }

  @override
  Future<Either<Failure, List<String>>> getCategories() async {
    return await getRepositoryCall<List<String>, List<String>>(
      _dataSource.getCategories,
      (json) => json,
    );
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProductsByCategory(
    String category,
  ) async {
    return await getRepositoryCall<List<ProductModel>,
        List<Map<String, dynamic>>>(
      () => _dataSource.getProductsByCategory(category),
      (json) => [
        for (final r in json) ProductModel.fromJson(r),
      ],
    );
  }

  @override
  Future<Either<Failure, ProductModel>> getProductById(int id) async {
    return await getRepositoryCall<ProductModel, Map<String, dynamic>>(
        () => _dataSource.getProductById(id),
        (json) => ProductModel.fromJson(json));
  }
}
