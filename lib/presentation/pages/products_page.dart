import 'package:auto_route/auto_route.dart';
import 'package:ecommerce/core/helper_functions.dart';
import 'package:ecommerce/core/service_locator.dart';
import 'package:ecommerce/presentation/bloc/products_page/products_page_cubit.dart';
import 'package:ecommerce/presentation/bloc/products_page/products_page_state.dart';
import 'package:ecommerce/presentation/widgets/products_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final category = context.routeData.pathParams.get("category") as String;

    return BlocProvider(
      create: (_) =>
          getIt<ProductsPageCubit>()..getProductsByCategory(category),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            capitaliseFirstLetter(
              category,
            ),
          ),
        ),
        body: BlocBuilder<ProductsPageCubit, ProductsPageState>(
          builder: (context, state) {
            return state.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : state.failure != null
                    ? Center(
                        child: Text(state.failure!.message),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8),
                        child: ProductsGridView(
                          products: state.products!,
                        ),
                      );
          },
        ),
      ),
    );
  }
}
