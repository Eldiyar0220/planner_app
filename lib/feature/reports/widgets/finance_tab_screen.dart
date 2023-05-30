import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyz_jubek/core/components/app_error_text.dart';
import 'package:kyz_jubek/core/components/app_indicator.dart';
import 'package:kyz_jubek/core/components/custom_button.dart';
import 'package:kyz_jubek/feature/calendar/domain/finance_cubit/finance_cubit.dart';
import 'package:kyz_jubek/feature/reports/cubits/filter_finance_cubit/filter_finance_cubit.dart';
import 'package:kyz_jubek/feature/reports/report_finance_detail_screen.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class FinanceTabScreen extends StatefulWidget {
  const FinanceTabScreen({super.key});

  @override
  State<FinanceTabScreen> createState() => _FinanceTabScreenState();
}

class _FinanceTabScreenState extends State<FinanceTabScreen> {
  String period = 'Месяц';
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              FinanceCubit()..getFiltredPeriodFinances(30, 'Доход'),
        ),
        BlocProvider(
          create: (context) =>
              FilterFinanceCubit()..getFiltredPeriodFinances(30, 'Расход'),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.color0180F5BlueDark,
                    ),
                    child: Builder(
                      builder: (context) => Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  period = 'Месяц';
                                });
                                context
                                    .read<FinanceCubit>()
                                    .getFiltredPeriodFinances(30, 'Доход');
                                context
                                    .read<FilterFinanceCubit>()
                                    .getFiltredPeriodFinances(30, 'Расход');
                              },
                              child: Text(
                                'Месяц',
                                textAlign: TextAlign.center,
                                style: period == 'Месяц'
                                    ? AppTextStyles.s20W700(
                                        color: Colors.white,
                                      )
                                    : AppTextStyles.s16W400(
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 2,
                            color: Colors.white,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  period = 'Год';
                                });
                                context
                                    .read<FinanceCubit>()
                                    .getFiltredPeriodFinances(365, 'Доход');
                                context
                                    .read<FilterFinanceCubit>()
                                    .getFiltredPeriodFinances(365, 'Расход');
                              },
                              child: Text(
                                'Год',
                                textAlign: TextAlign.center,
                                style: period == 'Год'
                                    ? AppTextStyles.s20W700(
                                        color: Colors.white,
                                      )
                                    : AppTextStyles.s16W400(
                                        color: Colors.white,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Доход за ${period.toLowerCase()}:',
                  style: AppTextStyles.s19W400(),
                ),
                BlocBuilder<FinanceCubit, FinanceState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => const AppIndicator(),
                      error: (error) => AppErrorText(error: error),
                      successGet: (model) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.length.toString(),
                            style: AppTextStyles.s19W700(),
                          ),
                          const SizedBox(height: 15),
                          CustomButton(
                            radius: 15,
                            text: 'Отчет',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ReportFinanceDetailScreen(
                                    listModels: model,
                                    title:
                                        'Отчет по доходам за ${period.toLowerCase()}',
                                    subTitle: 'Доход',
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Расход за ${period.toLowerCase()}:',
                  style: AppTextStyles.s19W400(),
                ),
                BlocBuilder<FilterFinanceCubit, FilterFinanceState>(
                  builder: (context, state) {
                    return state.when(
                      loading: () => const AppIndicator(),
                      error: (error) => AppErrorText(error: error),
                      success: (model) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.length.toString(),
                            style: AppTextStyles.s19W700(),
                          ),
                          const SizedBox(height: 15),
                          CustomButton(
                            radius: 15,
                            text: 'Отчет',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ReportFinanceDetailScreen(
                                    listModels: model,
                                    title:
                                        'Отчет по расходам за ${period.toLowerCase()}',
                                    subTitle: 'Расход',
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
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
