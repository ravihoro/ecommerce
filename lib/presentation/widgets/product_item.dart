import 'package:ecommerce/core/custom_colors.dart';
import 'package:ecommerce/domain/entities/product.dart';
import 'package:ecommerce/presentation/bloc/favorites/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    var favorites = context.watch<FavoritesCubit>().state.favorites ?? [];

    bool isFavorite =
        favorites.where((e) => e.id == product.id).toList().isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(5),
      height: 200,
      width: 150,
      color: CustomColors.greyBackground,
      child: Stack(
        children: [
          Column(
            spacing: 5,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  product.image,
                  height: 100,
                  width: double.infinity,
                ),
              ),
              Text(
                product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "\$${product.price.toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Positioned(
            top: 2,
            right: 2,
            child: InkWell(
              onTap: () {
                if (isFavorite) {
                  context.read<FavoritesCubit>().removeFavorite(product.id);
                } else {
                  context.read<FavoritesCubit>().addFavorite(product);
                }
              },
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_outline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
