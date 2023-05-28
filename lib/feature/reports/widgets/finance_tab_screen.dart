import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/custom_button.dart';
import 'package:kyz_jubek/core/components/date_formates.dart';
import 'package:kyz_jubek/feature/calendar/data/models/finance_model.dart';
import 'package:kyz_jubek/feature/calendar/domain/calendar_interactor.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class FinanceTabScreen extends StatefulWidget {
  const FinanceTabScreen({super.key});

  @override
  State<FinanceTabScreen> createState() => _FinanceTabScreenState();
}

class _FinanceTabScreenState extends State<FinanceTabScreen> {
  List<FinanceModel> listFinance = [];
  List<FinanceModel> listExpenses = [];

  //TODO: in progress
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final result =
            await CalendarInteractorImpl.getFinance('financeBox', 'Доход');
        if (result.isNotEmpty) {
          listFinance = [
            FinanceModel(
              notes: '',
              date: '27/03/2023',
              value: 10,
              type: 'Доход',
              id: 16851829812325,
            ),
            FinanceModel(
              notes: '',
              date: '23/04/2023',
              value: 10,
              type: 'Доход',
              id: 16851829813325,
            ),
            FinanceModel(
              notes: '',
              date: '27/06/2023',
              value: 15,
              type: 'Доход',
              id: 168518298133235,
            ),
            FinanceModel(
              notes: '',
              date: '27/05/2023',
              value: 15,
              type: 'Доход',
              id: 1685182981332235,
            ),
          ];
        }
        final resultListExpenses =
            await CalendarInteractorImpl.getFinance('financeBox', 'Расход');
        if (resultListExpenses.isNotEmpty) {
          // listExpenses = resultListExpenses;
          listExpenses = [
            FinanceModel(
              notes: '',
              date: '27/03/2023',
              value: 10,
              type: 'Доход',
              id: 16851829812325,
            ),
            FinanceModel(
              notes: '',
              date: '27/04/2023',
              value: 10,
              type: 'Доход',
              id: 16851829813325,
            ),
            FinanceModel(
              notes: '',
              date: '27/05/2023',
              value: 15,
              type: 'Доход',
              id: 168518298133235,
            ),
            FinanceModel(
              notes: '',
              date: '27/05/2023',
              value: 15,
              type: 'Доход',
              id: 1685182981332235,
            ),
          ];
        }
        setState(() {});
      },
    );
  }

  List<FinanceModel> doneWork(
    List<FinanceModel> list,
    bool doneOrNo,
    int dates,
  ) {
    List<FinanceModel> workList = list;

    workList.removeWhere((e) {
      DateTime dateFrom = dateFormatMain.parse(e.date);
      DateTime nowDate = DateTime.now();

      final result = nowDate.difference(dateFrom);
      return result.inDays < dates;
    });

    return workList;
  }

  //получение сумма расхода/дохода [месяц]
  String getAllFroMonth(List<FinanceModel> models, int dates) {
    List<FinanceModel> workList = models;

    workList.removeWhere((e) {
      DateTime dateFrom = dateFormatMain.parse(e.date);
      DateTime nowDate = DateTime.now();

      final result = nowDate.difference(dateFrom);
      return result.inDays > dates;
    });

    log(models.toString());
    var result = 0;
    for (var i = 0; i < workList.length; i++) {
      result += workList[i].value;
    }

    return '$result';
  }

  //получение сумма расхода/дохода [ГОД]
  String getAllFroYears(List<FinanceModel> models) {
    int dates = 365;
    var result = 0;

    models.removeWhere((e) {
      DateTime dateFrom = dateFormatMain.parse(e.date);
      DateTime nowDate = DateTime.now();

      final result = nowDate.difference(dateFrom);
      return result.inDays > dates;
    });
    for (var i = 0; i < models.length; i++) {
      result += models[i].value;
    }

    return '$result';
  }

  String period = 'Месяц';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Доход за ${period.toLowerCase()}:',
                style: AppTextStyles.s19W400(),
              ),
              Text(
                getAllFroMonth(listFinance, period == 'Месяц' ? 30 : 365),
                style: AppTextStyles.s19W700(),
              ),
              const SizedBox(height: 15),
              CustomButton(
                radius: 15,
                text: 'Отчет',
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ReportDetailScreen(
                  //       listModels: listFinance,
                  //       title: 'Отчет по доходам за ${period.toLowerCase()}',
                  //       subTitle: 'Доход',
                  //     ),
                  //   ),
                  // );
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Расход за ${period.toLowerCase()}:',
                style: AppTextStyles.s19W400(),
              ),
              Text(
                getAllFroMonth(listExpenses, period == 'Месяц' ? 30 : 365),
                style: AppTextStyles.s19W700(),
              ),
              const SizedBox(height: 15),
              CustomButton(
                radius: 15,
                text: 'Отчет',
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ReportDetailScreen(
                  //       listModels: listExpenses,
                  //       title: 'Отчет по расходам за ${period.toLowerCase()}',
                  //       subTitle: 'Расход',
                  //     ),
                  //   ),
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
