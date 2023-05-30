import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/spaces.dart';
import 'package:kyz_jubek/feature/calendar/data/models/work_model.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class ReportWorkDetailScreen extends StatelessWidget {
  const ReportWorkDetailScreen({
    super.key,
    required this.title,
    required this.subTitle,
    required this.listModels,
  });
  final String title;
  final String subTitle;
  final List<WorkModel> listModels;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.color0180F5BlueDark,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.s19W400(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: listModels.isEmpty
                  ? const Center(
                      child: Text('Пусто'),
                    )
                  : ListView.separated(
                      itemCount: listModels.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) => Container(
                        width: getWidth(context),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.color38B6FFBLue,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '$subTitle:',
                                  style: AppTextStyles.s15W400(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  listModels[index].date,
                                  style: AppTextStyles.s15W700(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              listModels[index].value,
                              style: AppTextStyles.s16W600(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      )),
    );
  }
}
