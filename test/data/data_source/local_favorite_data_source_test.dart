import 'package:ecommerce/core/database_helper.dart';
import 'package:ecommerce/core/exceptions.dart';
import 'package:ecommerce/data/data_source/favorite_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite/sqflite.dart';

import '../../mock_data.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

class MockDatabase extends Mock implements Database {}

void main() {
  late Database database;
  late DatabaseHelper dbHelper;

  late LocalFavoriteDataSource dataSource;

  setUp(() {
    database = MockDatabase();
    dbHelper = MockDatabaseHelper();
    dataSource = LocalFavoriteDataSource(dbHelper);

    when(() => dbHelper.database).thenAnswer((_) async => database);
  });

  test(
    'should successfully add product to favorite',
    () async {
      when(() => database.insert(
            'favorites',
            products[0].toJson(),
            conflictAlgorithm: any(named: 'conflictAlgorithm'),
          )).thenAnswer((_) async => 1);

      await expectLater(
        () async => await dataSource.addFavorite(products[0]),
        returnsNormally,
      );

      verify(() => database.insert(
            'favorites',
            products[0].toJson(),
            conflictAlgorithm: any(named: 'conflictAlgorithm'),
          )).called(1);
    },
  );

  test('should throw database insert exception', () async {
    when(() => database.insert('favorites', products[0].toJson(),
            conflictAlgorithm: any(named: 'conflictAlgorithm')))
        .thenThrow(DatabaseInsertException());

    await expectLater(
        () async => await dataSource.addFavorite(products[0]), throwsException);

    verify(() => database.insert(
          'favorites',
          products[0].toJson(),
          conflictAlgorithm: any(named: 'conflictAlgorithm'),
        )).called(1);
  });

  test(
    "should get all favorites",
    () async {
      when(() => database.query('favorites'))
          .thenAnswer((_) async => [for (final p in products) p.toJson()]);

      var response = await dataSource.getFavorites();

      expect(response, products);

      verify(() => database.query('favorites')).called(1);
    },
  );

  test(
    'should throw database fetch exception',
    () async {
      when(() => database.query('favorites'))
          .thenThrow(DatabaseFetchException());

      await expectLater(
          () async => await dataSource.getFavorites(), throwsException);

      verify(() => database.query('favorites')).called(1);
    },
  );

  test(
    'should delete product from favorites',
    () async {
      when(() => database.delete('favorites', where: 'id = ?', whereArgs: [5]))
          .thenAnswer((_) async => 1);

      await expectLater(
          () async => await dataSource.removeFavorite(5), returnsNormally);

      verify(() =>
              database.delete('favorites', where: 'id = ?', whereArgs: [5]))
          .called(1);
    },
  );

  test(
    'should throw Database delete exception',
    () async {
      when(() => database.delete('favorites', where: 'id = ?', whereArgs: [5]))
          .thenThrow(DatabaseDeleteException());

      await expectLater(
          () async => await dataSource.removeFavorite(5), throwsException);

      verify(() =>
              database.delete('favorites', where: 'id = ?', whereArgs: [5]))
          .called(1);
    },
  );
}
