// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyz_jubek/core/components/app_error_text.dart';
import 'package:kyz_jubek/core/components/app_indicator.dart';
import 'package:kyz_jubek/core/components/custom_button.dart';
import 'package:kyz_jubek/feature/calendar/domain/works_cubit/works_cubit.dart';
import 'package:kyz_jubek/feature/reports/report_detail_screen.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class WorksTabScreen extends StatefulWidget {
  const WorksTabScreen({super.key});

  @override
  State<WorksTabScreen> createState() => _WorksTabScreenState();
}

class _WorksTabScreenState extends State<WorksTabScreen> {
  String period = 'Месяц';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            period = 'Месяц';
                          });
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
            const SizedBox(height: 20),
            Text(
              'За ${period.toLowerCase()} выполнено всего:',
              style: AppTextStyles.s19W400(),
            ),
            BlocProvider(
              create: (context) => WorksCubit()
                ..getFiltredPeriodWorks(period == 'Месяц' ? 30 : 365, true),
              child: BlocBuilder<WorksCubit, WorksState>(
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
                          text: 'Список выполненных дел',
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReportDetailScreen(
                                  listModels: model,
                                  title:
                                      'Список выполненных дел за  ${period.toLowerCase()}',
                                  subTitle: 'Дело',
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
            ),
            const SizedBox(height: 20),
            Text(
              'За ${period.toLowerCase()} осталось:',
              style: AppTextStyles.s19W400(),
            ),
            BlocProvider(
              create: (context) => WorksCubit()
                ..getFiltredPeriodWorks(period == 'Месяц' ? 30 : 365, false),
              child: BlocBuilder<WorksCubit, WorksState>(
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
                          text: 'Список невыполненных дел',
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReportDetailScreen(
                                  listModels: model,
                                  title:
                                      'Список невыполненных дел за ${period.toLowerCase()}',
                                  subTitle: 'Дело',
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
            ),
          ],
        ),
      ),
    );
  }
}
