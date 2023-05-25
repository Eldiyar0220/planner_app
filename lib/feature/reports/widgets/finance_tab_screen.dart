import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/custom_button.dart';
import 'package:kyz_jubek/feature/reports/report_detail_screen.dart';
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
                '45 сом',
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
                      builder: (context) => ReportDetailScreen(
                        title: 'Отчет по доходам за ${period.toLowerCase()}',
                        subTitle: 'Доход',
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Расход за ${period.toLowerCase()}:',
                style: AppTextStyles.s19W400(),
              ),
              Text(
                '45 сом',
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
                      builder: (context) => ReportDetailScreen(
                        title: 'Отчет по расходам за ${period.toLowerCase()}',
                        subTitle: 'Расход',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
