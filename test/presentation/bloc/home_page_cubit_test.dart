import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce/domain/use_cases/get_products_by_category_use_case.dart';
import 'package:ecommerce/presentation/bloc/home_page/home_page_cubit.dart';
import 'package:ecommerce/presentation/bloc/home_page/home_page_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../mock_data.dart';

class MockGetCategoriesUseCase extends Mock implements GetCategoriesUseCase {}

class MockGetProductsByCategoryUseCase extends Mock
    implements GetProductsByCategoryUseCase {}

void main() {
  late MockGetCategoriesUseCase mockGetCategoriesUseCase;
  late MockGetProductsByCategoryUseCase mockGetProductsByCategoryUseCase;

  late HomePageCubit cubit;

  final serverFailure = ServerFailure('Server Failure');

  final productData = [for (final p in products) Product.fromModel(p)];

  setUp(() {
    mockGetCategoriesUseCase = MockGetCategoriesUseCase();
    mockGetProductsByCategoryUseCase = MockGetProductsByCategoryUseCase();
    cubit = HomePageCubit(
      mockGetCategoriesUseCase,
      mockGetProductsByCategoryUseCase,
    );
  });

  blocTest<HomePageCubit, HomePageState>(
    'successfully fetch categories',
    build: () => cubit,
    act: (cubit) => {
      when(mockGetCategoriesUseCase.getCategories)
          .thenAnswer((_) async => Right(mockCategories)),
      cubit.getCategories(),
    },
    expect: () => [
      HomePageState(isCategoriesLoading: true),
      HomePageState(isCategoriesLoading: false, categories: mockCategories),
    ],
  );

  blocTest<HomePageCubit, HomePageState>(
    'error when fetching categories',
    build: () => cubit,
    act: (cubit) {
      when(mockGetCategoriesUseCase.getCategories)
          .thenAnswer((_) async => Left(serverFailure));

      cubit.getCategories();
    },
    expect: () => [
      HomePageState(isCategoriesLoading: true),
      HomePageState(isCategoriesLoading: false, categoryFailure: serverFailure),
    ],
  );

  blocTest<HomePageCubit, HomePageState>(
    "successfully fetch men's products",
    build: () => cubit,
    act: (cubit) {
      when(() => mockGetProductsByCategoryUseCase.getProductsByCategory(
          "men's clothing")).thenAnswer((_) async => Right(productData));

      cubit.getMenProducts();
    },
    expect: () => [
      HomePageState(isMenProductsLoading: true),
      HomePageState(isMenProductsLoading: false, menProducts: productData),
    ],
  );
  blocTest<HomePageCubit, HomePageState>(
    "error when fetching men's products",
    build: () => cubit,
    act: (cubit) {
      when(() => mockGetProductsByCategoryUseCase.getProductsByCategory(
          "men's clothing")).thenAnswer((_) async => Left(serverFailure));

      cubit.getMenProducts();
    },
    expect: () => [
      HomePageState(isMenProductsLoading: true),
      HomePageState(
          isMenProductsLoading: false, menProductsFailure: serverFailure),
    ],
  );
  blocTest<HomePageCubit, HomePageState>(
    "successfully fetch women's products",
    build: () => cubit,
    act: (cubit) {
      when(() => mockGetProductsByCategoryUseCase.getProductsByCategory(
          "women's clothing")).thenAnswer((_) async => Right(productData));

      cubit.getWomenProducts();
    },
    expect: () => [
      HomePageState(isWomenProductsLoading: true),
      HomePageState(isWomenProductsLoading: false, womenProducts: productData),
    ],
  );
  blocTest<HomePageCubit, HomePageState>(
    "error when fetching women's products",
    build: () => cubit,
    act: (cubit) {
      when(() => mockGetProductsByCategoryUseCase.getProductsByCategory(
          "women's clothing")).thenAnswer((_) async => Left(serverFailure));

      cubit.getWomenProducts();
    },
    expect: () => [
      HomePageState(isWomenProductsLoading: true),
      HomePageState(
          isWomenProductsLoading: false, womenProductsFailure: serverFailure),
    ],
  );
}
