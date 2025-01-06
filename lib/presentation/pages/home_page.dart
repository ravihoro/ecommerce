import 'package:auto_route/auto_route.dart';
import 'package:ecommerce/presentation/bloc/home_page/home_page_cubit.dart';
import 'package:ecommerce/presentation/bloc/home_page/home_page_state.dart';
import 'package:ecommerce/presentation/widgets/home_page/home_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          return state.isCategoriesLoading &&
                  state.isMenProductsLoading &&
                  state.isWomenProductsLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state.categoryFailure != null
                  ? const Center(
                      child: Text(
                        'Something went wrong',
                      ),
                    )
                  : HomePageView(state: state);
        },
      ),
    );
  }
}
