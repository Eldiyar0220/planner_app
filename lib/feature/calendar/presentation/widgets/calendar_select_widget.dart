import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/spaces.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_decoration.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class CalendarContainerWidget extends StatelessWidget {
  const CalendarContainerWidget({
    super.key,
    required this.onTap,
    required this.title,
  });

  final Function() onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          width: getWidth(context),
          decoration: AppDecorations.defaultDeco(
            color: AppColors.color38B6FFBLue,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.s15W600(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
