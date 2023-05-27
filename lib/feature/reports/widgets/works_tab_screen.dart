// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/custom_button.dart';
import 'package:kyz_jubek/core/components/date_formates.dart';
import 'package:kyz_jubek/feature/calendar/data/models/work_model.dart';
import 'package:kyz_jubek/feature/calendar/domain/calendar_interactor.dart';
import 'package:kyz_jubek/feature/reports/report_detail_screen.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class WorksTabScreen extends StatefulWidget {
  const WorksTabScreen({super.key});

  @override
  State<WorksTabScreen> createState() => _WorksTabScreenState();
}

class _WorksTabScreenState extends State<WorksTabScreen> {
  List<WorkModel> models = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final result = await CalendarInteractorImpl.getDeals2('workBox');
        if (result.isNotEmpty) {
          models = result;
          setState(() {});
        }
      },
    );
  }

  List<WorkModel> doneWork(
    bool doneOrNo,
    int dates,
  ) {
    List<WorkModel> workList =
        models.where((model) => model.isComleted == doneOrNo).toList();

    workList.removeWhere((e) {
      DateTime dateFrom = dateFormatMain.parse(e.date);
      DateTime nowDate = DateTime.now();

      final result = nowDate.difference(dateFrom);
      return result.inDays > dates;
    });

    return workList;
  }

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doneWork(
                    true,
                    period == 'Месяц' ? 30 : 365,
                  ).length.toString(),
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
                          listModels: doneWork(
                            true,
                            period == 'Месяц' ? 30 : 365,
                          ),
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
            const SizedBox(height: 20),
            Text(
              'За ${period.toLowerCase()} осталось:',
              style: AppTextStyles.s19W400(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doneWork(
                    false,
                    period == 'Месяц' ? 30 : 365,
                  ).length.toString(),
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
                          listModels: doneWork(
                            false,
                            period == 'Месяц' ? 30 : 365,
                          ),
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
          ],
        ),
      ),
    );
  }
}
