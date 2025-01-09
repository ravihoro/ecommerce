import 'package:auto_route/auto_route.dart';
import 'package:ecommerce/presentation/bloc/product_detail/product_detail_cubit.dart';
import 'package:ecommerce/presentation/bloc/product_detail/product_detail_state.dart';
import 'package:ecommerce/presentation/widgets/product_detail/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final id = context.routeData.pathParams.get("id") as String;

    context.read<ProductDetailCubit>().getProductById(int.parse(id));

    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: state.product == null
                ? null
                : Text(
                    state.product!.title,
                  ),
          ),
          body: state.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state.failure != null
                  ? Center(
                      child: Text(state.failure!.message),
                    )
                  : ProductDetail(product: state.product),
        );
      },
    );
  }
}
