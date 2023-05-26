import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyz_jubek/core/components/app_error_text.dart';
import 'package:kyz_jubek/core/components/app_indicator.dart';
import 'package:kyz_jubek/core/components/spaces.dart';
import 'package:kyz_jubek/feature/home/data/smile_cubit/smile_cubit.dart';
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
    return BlocProvider(
      create: (context) => SmileCubit()..getSmiles(30),
      child: Scaffold(
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
                          child: Builder(
                            builder: (context) => InkWell(
                              onTap: () {
                                setState(() {
                                  period = 'Месяц';
                                });
                                context.read<SmileCubit>().getSmiles(30);
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
                        ),
                        Container(
                          height: 30,
                          width: 2,
                          color: Colors.white,
                        ),
                        Expanded(
                          child: Builder(
                            builder: (context) => InkWell(
                              onTap: () {
                                setState(() {
                                  period = 'Год';
                                });
                                context.read<SmileCubit>().getSmiles(365);
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
                BlocBuilder<SmileCubit, SmileState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => const AppIndicator(),
                      error: (error) => AppErrorText(error: error),
                      successGet: (model) => Column(
                        children: [
                          Text(
                            '5 --- ${(model.where((e) => e.item == 5)).length}',
                            style: AppTextStyles.s19W700(),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '4 --- ${(model.where((e) => e.item == 4)).length}',
                            style: AppTextStyles.s19W700(),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '3 --- ${(model.where((e) => e.item == 3)).length}',
                            style: AppTextStyles.s19W700(),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '2 --- ${(model.where((e) => e.item == 2)).length}',
                            style: AppTextStyles.s19W700(),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '1 --- ${(model.where((e) => e.item == 1)).length}',
                            style: AppTextStyles.s19W700(),
                          ),
                          const SizedBox(height: 16),
                          PieChart(
                            dataMap: {
                              "5": (model.where((e) => e.item == 5))
                                  .length
                                  .toDouble(),
                              "4": (model.where((e) => e.item == 4))
                                  .length
                                  .toDouble(),
                              "3": (model.where((e) => e.item == 3))
                                  .length
                                  .toDouble(),
                              "2": (model.where((e) => e.item == 2))
                                  .length
                                  .toDouble(),
                              "1": (model.where((e) => e.item == 1))
                                  .length
                                  .toDouble(),
                            },
                            animationDuration:
                                const Duration(milliseconds: 800),
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
