import 'package:flutter/material.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class FeelWidget extends StatelessWidget {
  const FeelWidget({
    super.key,
    required this.grade,
    required this.title,
    required this.subTitle,
    required this.isActive,
    required this.onTap,
  });

  final int grade;
  final String title;
  final String subTitle;
  final bool isActive;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isActive
                ? AppColors.color00FFFFLigtBlue
                : AppColors.color0180F5BlueDark,
            radius: 30,
            child: Text(
              grade.toString(),
              style: AppTextStyles.s28W600(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  title,
                  style: AppTextStyles.s20W400(),
                ),
                Text(
                  subTitle,
                  style: AppTextStyles.s15W400(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
