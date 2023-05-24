import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/spaces.dart';
import 'package:kyz_jubek/feature/info/info_detail_screen.dart';
import 'package:kyz_jubek/feature/info/info_model.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    super.key,
    required this.model,
  });

  final InfoModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoDetailScreen(model: model),
          ),
        );
      },
      child: Container(
        width: getWidth(context),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.colorFED5E4LightBlue,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Тема: ${model.title}',
              style: AppTextStyles.s16W400(),
            ),
            const SizedBox(height: 5),
            Text(
              'Описание: ${model.description}',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.s16W400(),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
