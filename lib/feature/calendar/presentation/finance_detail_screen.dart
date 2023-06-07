import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyz_jubek/core/components/app_error_text.dart';
import 'package:kyz_jubek/core/components/app_indicator.dart';
import 'package:kyz_jubek/core/components/custom_app_bar.dart';
import 'package:kyz_jubek/core/components/custom_button.dart';
import 'package:kyz_jubek/feature/calendar/data/models/finance_model.dart';
import 'package:kyz_jubek/feature/calendar/domain/finance_cubit/finance_cubit.dart';
import 'package:kyz_jubek/feature/calendar/presentation/widgets/finance_item_widget.dart';
import 'package:kyz_jubek/feature/calendar/presentation/widgets/show_add_dialog.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class FinanceDetailScreen extends StatefulWidget {
  const FinanceDetailScreen({super.key, required this.date});
  final String date;

  @override
  State<FinanceDetailScreen> createState() => _FinanceDetailScreenState();
}

class _FinanceDetailScreenState extends State<FinanceDetailScreen> {
  String type = 'Доход';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FinanceCubit()
        ..getFinances(
          widget.date,
          type,
        ),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Учет финансов'),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Text(
                  widget.date,
                  style: AppTextStyles.s16W400(),
                ),
                const SizedBox(height: 12),
                Builder(
                  builder: (context) => Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              type = 'Доход';
                            });
                            context
                                .read<FinanceCubit>()
                                .getFinances(widget.date, type);
                          },
                          child: Container(
                            color: AppColors.color38B6FFBLue,
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'Доход',
                              textAlign: TextAlign.center,
                              style: type == 'Доход'
                                  ? AppTextStyles.s18W700(
                                      color: Colors.white,
                                    )
                                  : AppTextStyles.s16W300(
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              type = 'Расход';
                            });
                            context
                                .read<FinanceCubit>()
                                .getFinances(widget.date, type);
                          },
                          child: Container(
                            color: AppColors.color38B6FFBLue,
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              'Расход',
                              textAlign: TextAlign.center,
                              style: type == 'Расход'
                                  ? AppTextStyles.s18W700(
                                      color: Colors.white,
                                    )
                                  : AppTextStyles.s16W300(
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: BlocBuilder<FinanceCubit, FinanceState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () => const AppIndicator(),
                        error: (error) => AppErrorText(error: error),
                        successGet: (model) => model.isEmpty
                            ? Center(
                                child: Text(
                                    'У вас нет ${type.toLowerCase()}а на эту дату'),
                              )
                            : ListView.separated(
                                itemCount: model.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) =>
                                    CalendarItemsWidget(
                                  model: model[index],
                                ),
                              ),
                      );
                    },
                  ),
                ),
                BlocConsumer<FinanceCubit, FinanceState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      successAdd: () {
                        context
                            .read<FinanceCubit>()
                            .getFinances(widget.date, type);
                      },
                    );
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: CustomButton(
                        radius: 8,
                        text: 'Добавить ${type.toLowerCase()}',
                        onPressed: () async {
                          final value = await showAddDialogWithNotes(
                            context,
                            type.toLowerCase(),
                            keyboardType: TextInputType.number,
                          );
                          if (value.mainText.isNotEmpty) {
                            final int id =
                                DateTime.now().millisecondsSinceEpoch;
                            context.read<FinanceCubit>().addFinances(
                                  FinanceModel(
                                    notes: value.notes,
                                    date: widget.date,
                                    value: int.parse(value.mainText),
                                    type: type,
                                    id: id,
                                  ),
                                );
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
