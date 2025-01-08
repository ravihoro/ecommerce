import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/exceptions.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/data/data_source/favorite_data_source.dart';
import 'package:ecommerce/data/repositories/favorite_repository_impl.dart';
import 'package:ecommerce/domain/repositories/favorite_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock_data.dart';

class MockFavoriteDataSource extends Mock implements FavoriteDataSource {}

void main() {
  late FavoriteDataSource dataSource;

  late FavoriteRepository repository;

  setUp(() {
    dataSource = MockFavoriteDataSource();
    repository = FavoriteRepositoryImpl(dataSource);
  });

  test(
    'should successfully add favorite product',
    () async {
      when(() => dataSource.addFavorite(products[0]))
          .thenAnswer((_) async => Right(true));

      var either = await repository.addFavorite(products[0]);

      expect(either, isA<Right>());

      final rightValue = either.fold((l) => null, (r) => r);

      expect(rightValue, true);

      verify(() => dataSource.addFavorite(products[0])).called(1);
    },
  );

  test(
    'should return database insert failure',
    () async {
      when(() => dataSource.addFavorite(products[0]))
          .thenThrow(DatabaseInsertException());

      var either = await repository.addFavorite(products[0]);

      expect(either, isA<Left>());

      final leftValue = either.fold((l) => l, (r) => null);

      expect(leftValue, isA<DatabaseInsertFailure>());

      verify(() => dataSource.addFavorite(products[0])).called(1);
    },
  );

  test(
    'should successfully remove favorite',
    () async {
      when(() => dataSource.removeFavorite(products[0].id))
          .thenAnswer((_) async => Right(true));

      var either = await repository.removeFavorite(products[0].id);

      expect(either, isA<Right>());

      final rightValue = either.fold((l) => null, (r) => r);

      expect(rightValue, true);

      verify(() => dataSource.removeFavorite(products[0].id)).called(1);
    },
  );

  test(
    'should return database delete failure',
    () async {
      when(() => dataSource.removeFavorite(products[0].id))
          .thenThrow(DatabaseDeleteException());

      var either = await repository.removeFavorite(products[0].id);

      expect(either, isA<Left>());

      final leftValue = either.fold((l) => l, (r) => null);

      expect(leftValue, isA<DatabaseDeleteFailure>());

      verify(() => dataSource.removeFavorite(products[0].id)).called(1);
    },
  );

  test(
    'should successfully fetch all favorites',
    () async {
      when(() => dataSource.getFavorites()).thenAnswer((_) async => products);

      var either = await repository.getFavorites();

      expect(either, isA<Right>());

      final rightValue = either.fold((l) => null, (r) => r);

      expect(rightValue, products);

      verify(() => dataSource.getFavorites()).called(1);
    },
  );

  test(
    'should return database fetch failure',
    () async {
      when(() => dataSource.getFavorites()).thenThrow(DatabaseFetchException());

      var either = await repository.getFavorites();

      expect(either, isA<Left>());

      final leftValue = either.fold((l) => l, (r) => null);

      expect(leftValue, isA<DatabaseFetchFailure>());

      verify(() => dataSource.getFavorites()).called(1);
    },
  );
}
