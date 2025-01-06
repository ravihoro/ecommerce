import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/repositories/product_repository.dart';
import 'package:ecommerce/domain/use_cases/get_all_products_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_data.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late ProductRepository productRepository;

  late GetAllProductsUseCase getAllProductsUseCase;

  final mockProductData = [
    for (final p in mockProducts) ProductModel.fromJson(p)
  ];

  final products = [for (final p in mockProductData) Product.fromModel(p)];

  setUp(() {
    productRepository = MockProductRepository();
    getAllProductsUseCase = GetAllProductsUseCase(productRepository);
  });

  test(
    'successfully fetch all products',
    () async {
      when(productRepository.getAllProducts)
          .thenAnswer((products) async => Right(mockProductData));

      var response = await getAllProductsUseCase.getAllProducts();

      verify(productRepository.getAllProducts).called(1);

      expect(response, isA<Right>());

      var rightValue = response.fold((l) => null, (r) => r);

      expect(rightValue, products);
    },
  );
}
