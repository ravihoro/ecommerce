import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

class FavoritesState extends Equatable {
  final List<Product>? favorites;
  final bool isLoading;
  final Failure? failure;

  const FavoritesState({
    this.favorites,
    this.isLoading = false,
    this.failure,
  });

  FavoritesState copyWith({
    List<Product>? favorites,
    bool? isLoading,
    Failure? failure,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        favorites,
        isLoading,
        failure,
      ];
}
