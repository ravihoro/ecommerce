import 'package:ecommerce/presentation/widgets/home_page/view_all_text.dart';
import 'package:flutter/widgets.dart';

class TitleRow extends StatelessWidget {
  final String title;
  final VoidCallback? onPress;

  const TitleRow({
    super.key,
    required this.title,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        ViewAllText(
          onPress: onPress,
        ),
      ],
    );
  }
}
