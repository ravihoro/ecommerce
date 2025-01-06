import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/exceptions.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/data/data_source/product_data_source.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/data/repositories/product_repository_impl.dart';
import 'package:ecommerce/domain/repositories/product_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock_data.dart';

class MockProductDataSource extends Mock implements ProductDataSource {}

void main() {
  late ProductDataSource mockProductDataSource;
  late ProductRepository repository;

  setUp(() {
    mockProductDataSource = MockProductDataSource();
    repository = ProductRepositoryImpl(mockProductDataSource);
  });

  test(
    'test successfully fetch all products',
    () async {
      when(mockProductDataSource.getAllProducts)
          .thenAnswer((_) async => mockProducts);

      var response = await repository.getAllProducts();

      verify(mockProductDataSource.getAllProducts).called(1);

      expect(response, isA<Right>());

      final rightValue = response.fold((l) => null, (r) => r);

      expect(rightValue, isA<List<ProductModel>>());
    },
  );

  test(
    'server error when making api error',
    () async {
      when(mockProductDataSource.getAllProducts).thenThrow(
        const ServerException(),
      );

      var response = await repository.getAllProducts();

      verify(mockProductDataSource.getAllProducts).called(1);

      expect(response, isA<Left>());

      final leftValue = response.fold((l) => l, (r) => null);

      expect(leftValue, isA<ServerFailure>());
    },
  );

  test(
    'successfully fetch categories',
    () async {
      when(mockProductDataSource.getCategories)
          .thenAnswer((_) async => mockCategories);

      var response = await repository.getCategories();

      expect(response, isA<Right>());

      verify(mockProductDataSource.getCategories).called(1);

      final rightValue = response.fold((l) => null, (response) => response);

      expect(rightValue, isA<List<String>>());
    },
  );

  test(
    'successfully fetch category products',
    () async {
      when(() => mockProductDataSource.getProductsByCategory('jewlery'))
          .thenAnswer((_) async => mockProducts);

      var response = await repository.getProductsByCategory('jewlery');

      verify(() => mockProductDataSource.getProductsByCategory('jewlery'))
          .called(1);

      expect(response, isA<Right>());

      final rightValue = response.fold((l) => null, (response) => response);

      expect(rightValue, isA<List<ProductModel>>());
    },
  );
}
