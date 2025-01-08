import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/repositories/favorite_repository.dart';
import 'package:ecommerce/domain/use_cases/add_favorite_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_data.dart';

class MockFavoriteRepository extends Mock implements FavoriteRepository {}

void main() {
  late FavoriteRepository repository;
  late AddFavoriteUseCase useCase;

  setUp(() {
    repository = MockFavoriteRepository();
    useCase = AddFavoriteUseCase(repository);
  });

  test(
    'should successfully add favorite',
    () async {
      when(() => repository.addFavorite(products[0]))
          .thenAnswer((_) async => Right(true));

      var either = await useCase.addFavorite(Product.fromModel(products[0]));

      expect(either, isA<Right>());

      final rightValue = either.fold((l) => null, (r) => r);

      expect(rightValue, true);

      verify(() => repository.addFavorite(products[0])).called(1);
    },
  );

  test(
    'should return database insert faliure',
    () async {
      when(() => repository.addFavorite(products[0]))
          .thenAnswer((_) async => Left(DatabaseInsertFailure('')));

      var either = await useCase.addFavorite(Product.fromModel(products[0]));

      expect(either, isA<Left>());

      final leftValue = either.fold((l) => l, (r) => null);

      expect(leftValue, isA<DatabaseInsertFailure>());

      verify(() => repository.addFavorite(products[0])).called(1);
    },
  );
}
