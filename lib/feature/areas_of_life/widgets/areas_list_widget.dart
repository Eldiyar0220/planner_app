import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/spaces.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class AreasListWidget extends StatelessWidget {
  const AreasListWidget({
    super.key,
    required this.onTap,
    required this.title,
  });

  final Function() onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: getWidth(context),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.color38B6FFBLue,
            ),
            child: Text(
              title,
              style: AppTextStyles.s18W400(
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
