import 'package:ecommerce/core/constants.dart';
import 'package:ecommerce/core/helper_functions.dart';
import 'package:ecommerce/presentation/bloc/home_page/home_page_state.dart';
import 'package:ecommerce/presentation/widgets/home_page/title_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryRow extends StatelessWidget {
  final HomePageState state;

  const CategoryRow({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return state.isCategoriesLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : state.categories!.isEmpty
            ? Center(
                child: Text(
                  "No categories found",
                ),
              )
            : Column(
                children: [
                  TitleRow(
                    title: "Categories",
                    onPress: () {},
                  ),
                  Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: state.categories!
                        .map(
                          (e) => SizedBox(
                            width: 70,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        CATEGORY_IMAGES[
                                            state.categories!.indexOf(e)],
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  capitaliseFirstLetter(e),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              );
  }
}
