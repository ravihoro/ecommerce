import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/repositories/product_repository.dart';
import 'package:ecommerce/domain/use_cases/get_products_by_category_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_data.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late ProductRepository productRepository;
  late GetProductsByCategoryUseCase getProductsByCategoryUseCase;

  final mockProductData = [
    for (final p in mockProducts) ProductModel.fromJson(p)
  ];

  setUp(
    () {
      productRepository = MockProductRepository();
      getProductsByCategoryUseCase =
          GetProductsByCategoryUseCase(productRepository);
    },
  );

  test(
    'successfully fetch products by category',
    () async {
      when(() => productRepository.getProductsByCategory('jewelery'))
          .thenAnswer(
        (_) async => Right(
          mockProductData,
        ),
      );

      var response =
          await getProductsByCategoryUseCase.getProductsByCategory('jewelery');

      verify(() => productRepository.getProductsByCategory('jewelery'))
          .called(1);

      expect(response, isA<Right>());

      final rightValue = response.fold((l) => null, (r) => r);

      expect(rightValue, isA<List<Product>>());
    },
  );

  test(
    'should return server failure',
    () async {
      when(() => productRepository.getProductsByCategory('jewelery'))
          .thenAnswer(
        (_) async => const Left(
          ServerFailure(''),
        ),
      );

      var response =
          await getProductsByCategoryUseCase.getProductsByCategory('jewelery');

      verify(() => productRepository.getProductsByCategory('jewelery'))
          .called(1);

      expect(response, isA<Left>());

      final leftValue = response.fold((l) => l, (r) => null);

      expect(leftValue, isA<ServerFailure>());
    },
  );
}
