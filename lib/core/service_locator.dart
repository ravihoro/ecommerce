import 'package:ecommerce/core/database_helper.dart';
import 'package:ecommerce/data/data_source/favorite_data_source.dart';
import 'package:ecommerce/data/data_source/product_data_source.dart';
import 'package:ecommerce/data/repositories/favorite_repository_impl.dart';
import 'package:ecommerce/data/repositories/product_repository_impl.dart';
import 'package:ecommerce/domain/repositories/favorite_repository.dart';
import 'package:ecommerce/domain/repositories/product_repository.dart';
import 'package:ecommerce/domain/use_cases/add_favorite_use_case.dart';
import 'package:ecommerce/domain/use_cases/get_all_products_use_case.dart';
import 'package:ecommerce/domain/use_cases/get_categories_use_case.dart';
import 'package:ecommerce/domain/use_cases/get_favorites_use_case.dart';
import 'package:ecommerce/domain/use_cases/get_products_by_category_use_case.dart';
import 'package:ecommerce/domain/use_cases/remove_favorite_use_case.dart';
import 'package:ecommerce/presentation/bloc/favorites/favorites_cubit.dart';
import 'package:ecommerce/presentation/bloc/home_page/home_page_cubit.dart';
import 'package:ecommerce/presentation/bloc/products_page/products_page_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<http.Client>(
    () => http.Client(),
  );

  getIt.registerLazySingleton<ProductDataSource>(
    () => RemoteProductDataSource(getIt<http.Client>()),
  );

  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(getIt<ProductDataSource>()),
  );

  getIt.registerLazySingleton<GetAllProductsUseCase>(
    () => GetAllProductsUseCase(getIt<ProductRepository>()),
  );

  getIt.registerLazySingleton<GetCategoriesUseCase>(
    () => GetCategoriesUseCase(getIt<ProductRepository>()),
  );

  getIt.registerLazySingleton<GetProductsByCategoryUseCase>(
    () => GetProductsByCategoryUseCase(getIt<ProductRepository>()),
  );

  getIt.registerLazySingleton<HomePageCubit>(
    () => HomePageCubit(
      getIt<GetCategoriesUseCase>(),
      getIt<GetProductsByCategoryUseCase>(),
    ),
  );

  getIt.registerFactory(
    () => ProductsPageCubit(
      getIt<GetProductsByCategoryUseCase>(),
    ),
  );

  getIt.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);

  getIt.registerLazySingleton<FavoriteDataSource>(
      () => LocalFavoriteDataSource(getIt<DatabaseHelper>()));

  getIt.registerLazySingleton<FavoriteRepository>(() => FavoriteRepositoryImpl(
        getIt<FavoriteDataSource>(),
      ));

  getIt.registerLazySingleton<GetFavoritesUseCase>(
      () => GetFavoritesUseCase(getIt<FavoriteRepository>()));

  getIt.registerLazySingleton<AddFavoriteUseCase>(
      () => AddFavoriteUseCase(getIt<FavoriteRepository>()));

  getIt.registerLazySingleton<RemoveFavoriteUseCase>(
      () => RemoveFavoriteUseCase(getIt<FavoriteRepository>()));

  getIt.registerLazySingleton<FavoritesCubit>(() => FavoritesCubit(
        getIt<AddFavoriteUseCase>(),
        getIt<GetFavoritesUseCase>(),
        getIt<RemoveFavoriteUseCase>(),
      ));
}
