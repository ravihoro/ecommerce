import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';

class ProductsGridView extends StatelessWidget {
  final List<Product> products;

  const ProductsGridView({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? Center(
            child: Text("No Products Found"),
          )
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              var product = products[index];
              return ProductItem(product: product);
            },
          );
  }
}
