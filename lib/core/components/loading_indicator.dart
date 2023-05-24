import 'package:flutter/material.dart';
import 'package:kyz_jubek/themes/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
    this.color = AppColors.color38B6FFBLue,
    this.strokeWidth = 2.5,
    this.radius = 24,
  }) : super(key: key);
  final Color? color;
  final double strokeWidth;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: radius,
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
