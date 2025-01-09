import 'package:ecommerce/core/app_router.dart';
import 'package:ecommerce/core/service_locator.dart';
import 'package:ecommerce/presentation/bloc/favorites/favorites_cubit.dart';
import 'package:ecommerce/presentation/bloc/home_page/home_page_cubit.dart';
import 'package:ecommerce/presentation/bloc/product_detail/product_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setup();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomePageCubit>(
          create: (_) => getIt<HomePageCubit>()
            ..getCategories()
            ..getMenProducts()
            ..getWomenProducts(),
        ),
        BlocProvider(
          create: (_) => getIt<FavoritesCubit>()..getFavorites(),
        ),
        BlocProvider(
          create: (_) => getIt<ProductDetailCubit>(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "e-commerce App",
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
