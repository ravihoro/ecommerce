// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:ecommerce/presentation/pages/category_page.dart' as _i1;
import 'package:ecommerce/presentation/pages/favorites_page.dart' as _i2;
import 'package:ecommerce/presentation/pages/home_page.dart' as _i3;
import 'package:ecommerce/presentation/pages/products_page.dart' as _i4;
import 'package:flutter/material.dart' as _i6;

/// generated route for
/// [_i1.CategoryPage]
class CategoryRoute extends _i5.PageRouteInfo<CategoryRouteArgs> {
  CategoryRoute({
    _i6.Key? key,
    required List<String> categories,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          CategoryRoute.name,
          args: CategoryRouteArgs(
            key: key,
            categories: categories,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoryRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CategoryRouteArgs>();
      return _i1.CategoryPage(
        key: args.key,
        categories: args.categories,
      );
    },
  );
}

class CategoryRouteArgs {
  const CategoryRouteArgs({
    this.key,
    required this.categories,
  });

  final _i6.Key? key;

  final List<String> categories;

  @override
  String toString() {
    return 'CategoryRouteArgs{key: $key, categories: $categories}';
  }
}

/// generated route for
/// [_i2.FavoritesPage]
class FavoritesRoute extends _i5.PageRouteInfo<void> {
  const FavoritesRoute({List<_i5.PageRouteInfo>? children})
      : super(
          FavoritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.FavoritesPage();
    },
  );
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomePage();
    },
  );
}

/// generated route for
/// [_i4.ProductsPage]
class ProductsRoute extends _i5.PageRouteInfo<void> {
  const ProductsRoute({List<_i5.PageRouteInfo>? children})
      : super(
          ProductsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductsRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.ProductsPage();
    },
  );
}
