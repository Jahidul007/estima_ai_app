import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';

class TitleWithBackground extends StatelessWidget {
  final String title;
  final Color? bgColor;
  final double? radius;

  const TitleWithBackground({
    Key? key,
    required this.title,
    this.bgColor = primaryColor,
    this.radius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Text(
        title,
        style: body2regular,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius!),
          color: bgColor?.withOpacity(0.2)),
    );
  }
}
