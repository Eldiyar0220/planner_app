import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/spaces.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.color,
  });
  final String title;
  final IconData icon;
  final Function() onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: onTap,
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: getWidth(context),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: color ?? AppColors.color38B6FFBLue,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: AppTextStyles.s16W400(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
