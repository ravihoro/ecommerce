import 'package:ecommerce/domain/use_cases/get_products_by_category_use_case.dart';
import 'package:ecommerce/presentation/bloc/products_page/products_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPageCubit extends Cubit<ProductsPageState> {
  final GetProductsByCategoryUseCase _getProductsByCategoryUseCase;

  final ProductsPageState? initialState;

  ProductsPageCubit(
    this._getProductsByCategoryUseCase, {
    this.initialState,
  }) : super(initialState ?? const ProductsPageState());

  Future<void> getProductsByCategory(String category) async {
    emit(state.copyWith(isLoading: true));
    var either =
        await _getProductsByCategoryUseCase.getProductsByCategory(category);

    if (!isClosed) {
      either.fold(
        (l) => emit(state.copyWith(isLoading: false, failure: l)),
        (r) => emit(
          state.copyWith(isLoading: false, products: r),
        ),
      );
    }
  }
}
