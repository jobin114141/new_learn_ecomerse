import 'package:flutter/material.dart';
import 'package:my_ecomerse/core/theme/styles.dart';

enum HeadingSize { small, medium, large }

class CustomTitleWidget extends StatelessWidget {
  final String title;
  final HeadingSize size;
  final bool isBold;
  final EdgeInsetsGeometry padding;
  final TextStyle? titleStyle;

  const CustomTitleWidget({
    super.key,
    required this.title,
    this.size = HeadingSize.medium,
    this.isBold = false,
    this.padding = EdgeInsets.zero,
    this.titleStyle,
  });

  double get _titleFontSize {
    switch (size) {
      case HeadingSize.small:
        return 14.0;
      case HeadingSize.medium:
        return 18.0;
      case HeadingSize.large:
        return 22.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseTitleStyle = isBold ? poppinsBold : poppinsSemiBold;

    return Padding(
      padding: padding,
      child: Text(
        title,
        style: titleStyle ??
            baseTitleStyle.copyWith(
              fontSize: _titleFontSize,
              color: Colors.black87,
            ),
      ),
    );
  }
}

