import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/presentation/widgets/home_page/product_item.dart';
import 'package:flutter/material.dart';

class ProductsRow extends StatelessWidget {
  final bool isLoading;
  final List<Product>? products;
  final Widget widget;

  const ProductsRow({
    super.key,
    required this.isLoading,
    required this.products,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : products == null || products!.isEmpty
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 10,
                      children: products!
                          .map((e) => ProductItem(product: e))
                          .toList(),
                    ),
                  ),
                ],
              );
  }
}
