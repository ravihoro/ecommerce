import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/use_cases/get_product_by_id_use_case.dart';
import 'package:ecommerce/presentation/bloc/product_detail/product_detail_cubit.dart';
import 'package:ecommerce/presentation/bloc/product_detail/product_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock_data.dart';

class MockGetProductByIdUseCase extends Mock implements GetProductByIdUseCase {}

void main() {
  late GetProductByIdUseCase useCase;

  late ProductDetailCubit cubit;

  var id = products[0].id;
  var productData = Product.fromModel(products[0]);

  setUp(() {
    useCase = MockGetProductByIdUseCase();
    cubit = ProductDetailCubit(useCase);
  });

  blocTest<ProductDetailCubit, ProductDetailState>(
    'should successfully fetch products',
    build: () => cubit,
    act: (cubit) {
      when(() => useCase.getProductById(id))
          .thenAnswer((_) async => Right(productData));

      cubit.getProductById(id);
    },
    expect: () => [
      const ProductDetailState(isLoading: true),
      ProductDetailState(
        isLoading: false,
        product: productData,
      ),
    ],
  );

  blocTest<ProductDetailCubit, ProductDetailState>(
    'should emit failure',
    build: () => cubit,
    act: (cubit) {
      when(() => useCase.getProductById(id))
          .thenAnswer((_) async => const Left(ServerFailure('')));

      cubit.getProductById(id);
    },
    expect: () => [
      const ProductDetailState(isLoading: true),
      const ProductDetailState(
        isLoading: false,
        failure: ServerFailure(''),
      ),
    ],
  );
}
