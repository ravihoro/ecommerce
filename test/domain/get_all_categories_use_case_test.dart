import 'package:dartz/dartz.dart';
import 'package:ecommerce/domain/repositories/product_repository.dart';
import 'package:ecommerce/domain/use_cases/get_categories_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_data.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late ProductRepository productRepository;

  late GetCategoriesUseCase getCategoriesUseCase;

  setUp(
    () {
      productRepository = MockProductRepository();
      getCategoriesUseCase = GetCategoriesUseCase(productRepository);
    },
  );

  test(
    'successfully fetch categories',
    () async {
      when(productRepository.getCategories)
          .thenAnswer((_) async => Right(mockCategories));

      var response = await getCategoriesUseCase.getCategories();

      verify(productRepository.getCategories).called(1);

      expect(response, isA<Right>());

      final rightValue = response.fold((l) => null, (r) => r);

      expect(rightValue, isA<List<String>>());
    },
  );
}
