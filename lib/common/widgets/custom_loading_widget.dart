import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  final double? radius;
  final Color? color;
  const CustomLoadingWidget({super.key,  this.radius, this.color});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        radius: radius ?? 15.0,
        color: color ?? Colors.deepPurple,
      ),
    );
  }
}
