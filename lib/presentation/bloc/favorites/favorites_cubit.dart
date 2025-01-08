import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/use_cases/add_favorite_use_case.dart';
import 'package:ecommerce/domain/use_cases/get_favorites_use_case.dart';
import 'package:ecommerce/domain/use_cases/remove_favorite_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavoritesUseCase _getFavoritesUseCase;
  final AddFavoriteUseCase _addFavoriteUseCase;
  final RemoveFavoriteUseCase _removeFavoriteUseCase;

  final FavoritesState? initialState;

  FavoritesCubit(
    this._addFavoriteUseCase,
    this._getFavoritesUseCase,
    this._removeFavoriteUseCase, {
    this.initialState,
  }) : super(initialState ?? const FavoritesState());

  Future<void> addFavorite(Product product) async {
    emit(state.copyWith(isLoading: true));
    var either = await _addFavoriteUseCase.addFavorite(product);
    either.fold(
      (l) => emit(
        state.copyWith(
          isLoading: false,
          failure: l,
        ),
      ),
      (r) => getFavorites(),
    );
  }

  Future<void> removeFavorite(int id) async {
    emit(state.copyWith(isLoading: true));
    var either = await _removeFavoriteUseCase.removeFavorite(id);
    either.fold(
      (l) => emit(state.copyWith(
        isLoading: false,
        failure: l,
      )),
      (r) => getFavorites(),
    );
  }

  Future<void> getFavorites() async {
    emit(state.copyWith(isLoading: true));

    var either = await _getFavoritesUseCase.getFavorites();

    either.fold(
      (l) => emit(
        state.copyWith(
          isLoading: false,
          failure: l,
        ),
      ),
      (r) => emit(
        state.copyWith(
          isLoading: false,
          favorites: r,
        ),
      ),
    );
  }
}
