import 'package:flutter/material.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_decoration.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class MainSimpleButton extends StatelessWidget {
  const MainSimpleButton({
    super.key,
    required this.onTap,
    required this.title,
    this.height = 60,
    this.color,
    this.width,
    this.isLoading = false,
  });

  final Function() onTap;
  final String title;
  final double height;
  final double? width;
  final Color? color;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: AppDecorations.defaultDeco(
          color: color ?? AppColors.black.withOpacity(0.3),
        ),
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                title,
                style: AppTextStyles.s15W400(color: AppColors.white),
              ),
      ),
    );
  }
}
