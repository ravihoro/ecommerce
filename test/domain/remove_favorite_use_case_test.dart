import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/domain/repositories/favorite_repository.dart';
import 'package:ecommerce/domain/use_cases/remove_favorite_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_data.dart';

class MockFavoriteRepository extends Mock implements FavoriteRepository {}

void main() {
  late FavoriteRepository repository;
  late RemoveFavoriteUseCase useCase;

  setUp(() {
    repository = MockFavoriteRepository();
    useCase = RemoveFavoriteUseCase(repository);
  });

  test(
    'should successfully remove favorite',
    () async {
      when(() => repository.removeFavorite(products[0].id))
          .thenAnswer((_) async => Right(true));

      var either = await useCase.removeFavorite(products[0].id);

      expect(either, isA<Right>());

      final rightValue = either.fold((l) => null, (r) => r);

      expect(rightValue, true);

      verify(() => repository.removeFavorite(products[0].id)).called(1);
    },
  );

  test(
    'should return database delete faliure',
    () async {
      when(() => repository.removeFavorite(products[0].id))
          .thenAnswer((_) async => Left(DatabaseDeleteFailure('')));

      var either = await useCase.removeFavorite(products[0].id);

      expect(either, isA<Left>());

      final leftValue = either.fold((l) => l, (r) => null);

      expect(leftValue, isA<DatabaseDeleteFailure>());

      verify(() => repository.removeFavorite(products[0].id)).called(1);
    },
  );
}
