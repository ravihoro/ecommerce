import 'package:auto_route/auto_route.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:ecommerce/presentation/bloc/favorites/favorites_cubit.dart';
import 'package:ecommerce/presentation/bloc/favorites/favorites_state.dart';
import 'package:ecommerce/presentation/widgets/products_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Products"),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          return state.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : (state.failure != null && state.failure is DatabaseFetchFailure)
                  ? Center(
                      child: Text(state.failure!.message),
                    )
                  : ProductsGridView(
                      products: state.favorites ?? [],
                    );
        },
      ),
    );
  }
}
