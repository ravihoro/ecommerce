import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewAllText extends StatelessWidget {
  final VoidCallback? onPress;

  const ViewAllText({
    super.key,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onPress,
        child: Text(
          "View All",
          style: TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
