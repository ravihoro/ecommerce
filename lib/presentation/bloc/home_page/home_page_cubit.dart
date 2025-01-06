import 'package:ecommerce/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce/domain/use_cases/get_products_by_category_use_case.dart';
import 'package:ecommerce/presentation/bloc/home_page/home_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetProductsByCategoryUseCase _getProductsByCategoryUseCase;
  final HomePageState? initialState;

  HomePageCubit(this._getCategoriesUseCase, this._getProductsByCategoryUseCase,
      {this.initialState})
      : super(
          initialState ?? HomePageState(),
        );

  Future<void> getCategories() async {
    emit(state.copyWith(isCategoriesLoading: true));
    var either = await _getCategoriesUseCase.getCategories();
    either.fold(
      (l) => emit(
        state.copyWith(isCategoriesLoading: false, categoryFailure: l),
      ),
      (r) => emit(
        state.copyWith(isCategoriesLoading: false, categories: r),
      ),
    );
  }

  Future<void> getMenProducts() async {
    emit(state.copyWith(isMenProductsLoading: true));
    var either = await _getProductsByCategoryUseCase
        .getProductsByCategory("men's clothing");
    either.fold(
        (l) => emit(
            state.copyWith(isMenProductsLoading: false, menProductsFailure: l)),
        (r) =>
            emit(state.copyWith(isMenProductsLoading: false, menProducts: r)));
  }

  Future<void> getWomenProducts() async {
    emit(state.copyWith(isWomenProductsLoading: true));
    var either = await _getProductsByCategoryUseCase
        .getProductsByCategory("women's clothing");

    either.fold(
        (l) => emit(state.copyWith(
            isWomenProductsLoading: false, womenProductsFailure: l)),
        (r) => emit(
            state.copyWith(isWomenProductsLoading: false, womenProducts: r)));
  }
}