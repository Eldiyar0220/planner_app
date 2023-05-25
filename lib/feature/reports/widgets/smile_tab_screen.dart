import 'package:kyz_jubek/core/components/spaces.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class SmileTabScreen extends StatefulWidget {
  const SmileTabScreen({super.key});

  @override
  State<SmileTabScreen> createState() => _SmileTabScreenState();
}

class _SmileTabScreenState extends State<SmileTabScreen> {
  String period = 'Месяц';

  Map<String, double> dataMap = {
    "5": 12,
    "4": 7,
    "3": 3,
    "2": 9,
    "1": 11,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                'Настроение за ${period.toLowerCase()}:',
                style: AppTextStyles.s19W400(),
              ),
              const SizedBox(height: 15),
              Text(
                '5 --- 7',
                style: AppTextStyles.s19W700(),
              ),
              const SizedBox(height: 8),
              Text(
                '4 --- 12',
                style: AppTextStyles.s19W700(),
              ),
              const SizedBox(height: 8),
              Text(
                '3 --- 9',
                style: AppTextStyles.s19W700(),
              ),
              const SizedBox(height: 8),
              Text(
                '2 --- 4',
                style: AppTextStyles.s19W700(),
              ),
              const SizedBox(height: 8),
              Text(
                '1 --- 2',
                style: AppTextStyles.s19W700(),
              ),
              const SizedBox(height: 16),
              PieChart(
                dataMap: dataMap,
                animationDuration: const Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: getWidth(context) / 2,
                colorList: const [
                  Colors.red,
                  AppColors.color0180F5BlueDark,
                  AppColors.color00FFFFLigtBlue,
                  AppColors.color333333Grey,
                  AppColors.color05FF00LightGreen
                ],
                initialAngleInDegree: 0,
                chartType: ChartType.disc,
                legendOptions: const LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: const ChartValuesOptions(
                  showChartValueBackground: false,
                  showChartValues: true,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: true,
                  decimalPlaces: 0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
