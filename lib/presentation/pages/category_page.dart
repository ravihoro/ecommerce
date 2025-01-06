import 'package:auto_route/auto_route.dart';
import 'package:ecommerce/core/constants.dart';
import 'package:ecommerce/core/custom_colors.dart';
import 'package:ecommerce/core/helper_functions.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CategoryPage extends StatelessWidget {
  final List<String> categories;

  const CategoryPage({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop By Categories"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: categories
              .map(
                (e) => Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: CustomColors.greyBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    spacing: 10,
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(),
                          image: DecorationImage(
                            image: NetworkImage(
                              CATEGORY_IMAGES[categories.indexOf(e)],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          capitaliseFirstLetter(e),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
