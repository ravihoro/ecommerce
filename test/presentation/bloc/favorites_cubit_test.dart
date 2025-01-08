import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/use_cases/add_favorite_use_case.dart';
import 'package:ecommerce/domain/use_cases/get_favorites_use_case.dart';
import 'package:ecommerce/domain/use_cases/remove_favorite_use_case.dart';
import 'package:ecommerce/presentation/bloc/favorites/favorites_cubit.dart';
import 'package:ecommerce/presentation/bloc/favorites/favorites_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock_data.dart';

class MockGetFavoritesUseCase extends Mock implements GetFavoritesUseCase {}

class MockAddFavoriteuseCase extends Mock implements AddFavoriteUseCase {}

class MockRemoveFavoriteUseCase extends Mock implements RemoveFavoriteUseCase {}

void main() {
  late GetFavoritesUseCase getFavoritesUseCase;
  late AddFavoriteUseCase addFavoriteUseCase;
  late RemoveFavoriteUseCase removeFavoriteUseCase;

  late FavoritesCubit cubit;

  late final productData = [for (final p in products) Product.fromModel(p)];

  setUp(() {
    getFavoritesUseCase = MockGetFavoritesUseCase();
    addFavoriteUseCase = MockAddFavoriteuseCase();
    removeFavoriteUseCase = MockRemoveFavoriteUseCase();

    cubit = FavoritesCubit(
      addFavoriteUseCase,
      getFavoritesUseCase,
      removeFavoriteUseCase,
    );
  });

  blocTest<FavoritesCubit, FavoritesState>(
    'should successfully get favorites',
    build: () => cubit,
    act: (cubit) {
      when(getFavoritesUseCase.getFavorites)
          .thenAnswer((_) async => Right(productData));

      cubit.getFavorites();
    },
    expect: () => [
      const FavoritesState(isLoading: true),
      FavoritesState(isLoading: false, favorites: productData),
    ],
  );

  blocTest<FavoritesCubit, FavoritesState>(
    'should get database failure',
    build: () => cubit,
    act: (cubit) {
      when(getFavoritesUseCase.getFavorites).thenAnswer(
        (_) async => Left(
          const DatabaseFetchFailure(''),
        ),
      );

      cubit.getFavorites();
    },
    expect: () => [
      const FavoritesState(isLoading: true),
      FavoritesState(
        isLoading: false,
        failure: const DatabaseFetchFailure(''),
      ),
    ],
  );

  blocTest<FavoritesCubit, FavoritesState>(
    'should successfully add favorite',
    build: () => cubit,
    act: (cubit) async {
      when(() => addFavoriteUseCase.addFavorite(productData[0])).thenAnswer(
        (_) async => Right(true),
      );

      when(getFavoritesUseCase.getFavorites).thenAnswer(
        (_) async => Right(productData),
      );

      cubit.addFavorite(productData[0]);
    },
    expect: () => [
      const FavoritesState(isLoading: true),
      FavoritesState(isLoading: false, favorites: productData),
    ],
  );

  blocTest<FavoritesCubit, FavoritesState>(
    'should get database insert failure',
    build: () => cubit,
    act: (cubit) async {
      when(() => addFavoriteUseCase.addFavorite(productData[0])).thenAnswer(
        (_) async => Left(
          const DatabaseInsertFailure(''),
        ),
      );

      cubit.addFavorite(productData[0]);
    },
    expect: () => [
      const FavoritesState(isLoading: true),
      FavoritesState(
        isLoading: false,
        failure: const DatabaseInsertFailure(''),
      ),
    ],
  );

  blocTest<FavoritesCubit, FavoritesState>(
    'should successfully remove favorite',
    build: () => FavoritesCubit(
      addFavoriteUseCase,
      getFavoritesUseCase,
      removeFavoriteUseCase,
      initialState: FavoritesState(
        favorites: productData,
      ),
    ),
    act: (cubit) async {
      when(() => removeFavoriteUseCase.removeFavorite(productData[0].id))
          .thenAnswer((_) async => Right(true));

      when(getFavoritesUseCase.getFavorites).thenAnswer((_) async => Right([]));

      cubit.removeFavorite(productData[0].id);
    },
    expect: () => [
      FavoritesState(isLoading: true, favorites: productData),
      FavoritesState(
        isLoading: false,
        favorites: [],
      ),
    ],
  );

  blocTest<FavoritesCubit, FavoritesState>(
    'should get database delete failure',
    build: () => FavoritesCubit(
      addFavoriteUseCase,
      getFavoritesUseCase,
      removeFavoriteUseCase,
      initialState: FavoritesState(
        favorites: productData,
      ),
    ),
    act: (cubit) async {
      when(() => removeFavoriteUseCase.removeFavorite(productData[0].id))
          .thenAnswer(
        (_) async => Left(
          const DatabaseDeleteFailure(''),
        ),
      );

      cubit.removeFavorite(productData[0].id);
    },
    expect: () => [
      FavoritesState(isLoading: true, favorites: productData),
      FavoritesState(
        isLoading: false,
        favorites: productData,
        failure: const DatabaseDeleteFailure(''),
      ),
    ],
  );
}
