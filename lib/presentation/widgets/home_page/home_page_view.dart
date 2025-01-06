import 'package:auto_route/auto_route.dart';
import 'package:ecommerce/presentation/bloc/home_page/home_page_state.dart';
import 'package:ecommerce/presentation/widgets/home_page/category_row.dart';
import 'package:ecommerce/presentation/widgets/home_page/products_row.dart';
import 'package:ecommerce/presentation/widgets/home_page/title_row.dart';
import 'package:flutter/material.dart';

class HomePageView extends StatelessWidget {
  final HomePageState state;

  const HomePageView({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        spacing: 10,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          CategoryRow(state: state),
          ProductsRow(
            widget: TitleRow(
              title: "Men's Clothing",
              onPress: () {
                context.router.pushNamed('/category/${state.categories![2]}');
              },
            ),
            isLoading: state.isMenProductsLoading,
            products: state.menProducts,
          ),
          ProductsRow(
            widget: TitleRow(
              title: "Women's Clothing",
              onPress: () {
                context.router.pushNamed('/category/${state.categories![3]}');
              },
            ),
            isLoading: state.isWomenProductsLoading,
            products: state.womenProducts,
          ),
        ],
      ),
    );
  }
}
