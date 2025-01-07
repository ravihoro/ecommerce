import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:auto_route/auto_route.dart';
import 'package:ecommerce/presentation/bloc/home_page/home_page_cubit.dart';
import 'package:ecommerce/presentation/bloc/home_page/home_page_state.dart';
import 'package:ecommerce/presentation/widgets/home_page/home_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppLinks _appLinks;
  late final StreamSubscription _linkSubscription;

  @override
  initState() {
    super.initState();
    _initDeepLinkingHandling();
  }

  Future<void> _initDeepLinkingHandling() async {
    _appLinks = AppLinks();
    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      _handleDeepLink(initialLink);
    }

    _linkSubscription = _appLinks.uriLinkStream.listen((link) {
      if (initialLink.toString() != link.toString()) {
        _handleDeepLink(link);
      }
    });
  }

  void _handleDeepLink(Uri uri) {
    if (uri.toString().contains('category') && uri.pathSegments.length == 1) {
      final category = uri.pathSegments[0];
      context.router.pushNamed('/category/$category');
    }
  }

  @override
  void dispose() {
    _linkSubscription.cancel();
    super.dispose();
  }

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
