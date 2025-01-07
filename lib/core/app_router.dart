import 'package:auto_route/auto_route.dart';
import 'package:ecommerce/core/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          path: "/",
          initial: true,
        ),
        AutoRoute(
          page: CategoryRoute.page,
          path: '/categories',
        ),
        AutoRoute(
          page: ProductsRoute.page,
          path: '/category/:category',
        ),
      ];
}
