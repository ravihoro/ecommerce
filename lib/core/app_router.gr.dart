// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:ecommerce/presentation/pages/category_page.dart' as _i1;
import 'package:ecommerce/presentation/pages/home_page.dart' as _i2;
import 'package:flutter/material.dart' as _i4;

/// generated route for
/// [_i1.CategoryPage]
class CategoryRoute extends _i3.PageRouteInfo<CategoryRouteArgs> {
  CategoryRoute({
    _i4.Key? key,
    required List<String> categories,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          CategoryRoute.name,
          args: CategoryRouteArgs(
            key: key,
            categories: categories,
          ),
          initialChildren: children,
        );

  static const String name = 'CategoryRoute';

  static _i3.PageInfo page = _i3.PageInfo(
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

  final _i4.Key? key;

  final List<String> categories;

  @override
  String toString() {
    return 'CategoryRouteArgs{key: $key, categories: $categories}';
  }
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}
