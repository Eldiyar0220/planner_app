import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyz_jubek/core/components/delete_dismissible_widget.dart';
import 'package:kyz_jubek/core/components/spaces.dart';
import 'package:kyz_jubek/feature/calendar/data/models/finance_model.dart';
import 'package:kyz_jubek/feature/calendar/domain/finance_cubit/finance_cubit.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class CalendarItemsWidget extends StatelessWidget {
  const CalendarItemsWidget({
    super.key,
    required this.model,
  });

  final FinanceModel model;

  @override
  Widget build(BuildContext context) {
    return DeleteDismissibleWidget(
      onDelete: () {
        context.read<FinanceCubit>().deleteFinances(model.id);
        context.read<FinanceCubit>().getFinances(model.date, model.type);
      },
      child: Container(
        width: getWidth(context),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.color38B6FFBLue,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${model.type} - ${model.value} сом',
              style: AppTextStyles.s18W400(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10.0),
            if (model.notes.isNotEmpty)
              Text(
                'Заметки: ${model.notes}',
                style: AppTextStyles.s18W400(
                  color: Colors.white,
                ),
              ),
            const SizedBox(height: 16),
            Text(
              model.date,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
