import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/repositories/favorite_repository.dart';
import 'package:ecommerce/domain/use_cases/get_favorites_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_data.dart';

class MockFavoriteRepository extends Mock implements FavoriteRepository {}

void main() {
  late FavoriteRepository repository;
  late GetFavoritesUseCase useCase;

  setUp(() {
    repository = MockFavoriteRepository();
    useCase = GetFavoritesUseCase(repository);
  });

  test(
    'should successfully get faovorites',
    () async {
      when(() => repository.getFavorites())
          .thenAnswer((_) async => Right(products));

      var either = await useCase.getFavorites();

      expect(either, isA<Right>());

      final rightValue = either.fold((l) => null, (r) => r);

      expect(rightValue, [for (final p in products) Product.fromModel(p)]);

      verify(() => repository.getFavorites()).called(1);
    },
  );

  test(
    'should return database fetch faliure',
    () async {
      when(() => repository.getFavorites())
          .thenAnswer((_) async => Left(DatabaseInsertFailure('')));

      var either = await useCase.getFavorites();

      expect(either, isA<Left>());

      final leftValue = either.fold((l) => l, (r) => null);

      expect(leftValue, isA<DatabaseInsertFailure>());

      verify(() => repository.getFavorites()).called(1);
    },
  );
}
