import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/use_cases/get_products_by_category_use_case.dart';
import 'package:ecommerce/presentation/bloc/products_page/products_page_cubit.dart';
import 'package:ecommerce/presentation/bloc/products_page/products_page_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock_data.dart';

class MockGetProductsByCategoryUseCase extends Mock
    implements GetProductsByCategoryUseCase {}

void main() {
  late MockGetProductsByCategoryUseCase mockGetProductsByCategoryUseCase;

  late ProductsPageCubit cubit;

  final serverFailure = ServerFailure('Server Failure');

  final productData = [for (final p in products) Product.fromModel(p)];

  setUp(() {
    mockGetProductsByCategoryUseCase = MockGetProductsByCategoryUseCase();
    cubit = ProductsPageCubit(
      mockGetProductsByCategoryUseCase,
    );
  });

  blocTest<ProductsPageCubit, ProductsPageState>(
    'should successfully fetch category products',
    build: () => cubit,
    act: (cubit) {
      when(() => mockGetProductsByCategoryUseCase.getProductsByCategory(
          'jewelery')).thenAnswer((_) async => Right(productData));

      cubit.getProductsByCategory('jewelery');
    },
    expect: () => [
      const ProductsPageState(isLoading: true),
      ProductsPageState(isLoading: false, products: productData),
    ],
  );

  blocTest<ProductsPageCubit, ProductsPageState>(
    'should get error when fetching category products',
    build: () => cubit,
    act: (cubit) {
      when(() => mockGetProductsByCategoryUseCase.getProductsByCategory(
          'jewelery')).thenAnswer((_) async => Left(serverFailure));

      cubit.getProductsByCategory('jewelery');
    },
    expect: () => [
      const ProductsPageState(isLoading: true),
      ProductsPageState(isLoading: false, failure: serverFailure),
    ],
  );
}
