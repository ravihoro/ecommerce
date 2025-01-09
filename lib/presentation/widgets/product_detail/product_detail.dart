import 'package:ecommerce/core/custom_colors.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final Product? product;

  const ProductDetail({
    super.key,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Center(
            child: Text("Failed to get product data"),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 10,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 10,
                    children: List.generate(
                      5,
                      (_) => Image.network(
                        product!.image,
                        height: 200,
                        width: 150,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    color: CustomColors.greyBackground,
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 3,
                      children: [
                        Text(
                          product!.rating.rate.toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                        Icon(Icons.star),
                        Text(
                          product!.rating.count.toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  product!.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$ ${product!.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: CustomColors.greyBackground,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    product!.description,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
