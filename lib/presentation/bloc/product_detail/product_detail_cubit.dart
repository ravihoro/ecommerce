import 'package:ecommerce/domain/use_cases/get_product_by_id_use_case.dart';
import 'package:ecommerce/presentation/bloc/product_detail/product_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final GetProductByIdUseCase _useCase;

  ProductDetailCubit(this._useCase) : super(ProductDetailState());

  Future<void> getProductById(int id) async {
    emit(state.copyWith(isLoading: true));
    var either = await _useCase.getProductById(id);
    either.fold(
      (l) => emit(
        state.copyWith(isLoading: false, failure: l),
      ),
      (r) => emit(
        state.copyWith(isLoading: false, product: r),
      ),
    );
  }
}
