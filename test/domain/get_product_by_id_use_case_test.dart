import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/repositories/product_repository.dart';
import 'package:ecommerce/domain/use_cases/get_product_by_id_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_data.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late ProductRepository repository;
  late GetProductByIdUseCase useCase;

  setUp(() {
    repository = MockProductRepository();
    useCase = GetProductByIdUseCase(repository);
  });

  test(
    'should successfully return product',
    () async {
      var id = products[0].id;
      when(() => repository.getProductById(id))
          .thenAnswer((_) async => Right(products[0]));

      var response = await useCase.getProductById(id);

      verify(() => repository.getProductById(id)).called(1);

      expect(response, Right(Product.fromModel(products[0])));
    },
  );

  test(
    'should return a failure when fetching product by id',
    () async {
      var id = products[0].id;
      when(() => repository.getProductById(id))
          .thenAnswer((_) async => const Left(ServerFailure('')));

      var response = await useCase.getProductById(id);

      verify(() => repository.getProductById(id)).called(1);

      expect(response, const Left(ServerFailure('')));
    },
  );
}
