import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/custom_app_bar.dart';
import 'package:kyz_jubek/core/components/spaces.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';
import 'package:pie_chart/pie_chart.dart';

class AreasItogScreen extends StatefulWidget {
  const AreasItogScreen({
    super.key,
    required this.theme1,
    required this.theme2,
    required this.theme3,
    required this.theme4,
    required this.theme5,
    required this.theme6,
    required this.theme7,
    required this.theme8,
    required this.theme9,
    required this.theme10,
    required this.theme11,
    required this.theme12,
  });
  final int theme1;
  final int theme2;
  final int theme3;
  final int theme4;
  final int theme5;
  final int theme6;
  final int theme7;
  final int theme8;
  final int theme9;
  final int theme10;
  final int theme11;
  final int theme12;

  @override
  State<AreasItogScreen> createState() => _AreasItogScreenState();
}

class _AreasItogScreenState extends State<AreasItogScreen> {
  late final Map<String, double> data = {
    'Отношения': widget.theme1.toDouble(),
    'Дружба': widget.theme2.toDouble(),
    'Приключения': widget.theme3.toDouble(),
    'Здоровье и спорт': widget.theme4.toDouble(),
    'Обстановка': widget.theme5.toDouble(),
    'Интеллектуальная жизнь': widget.theme6.toDouble(),
    'Навыки': widget.theme7.toDouble(),
    'Духовная жизнь': widget.theme8.toDouble(),
    'Карьера': widget.theme9.toDouble(),
    'Творчество': widget.theme10.toDouble(),
    'Семья': widget.theme11.toDouble(),
    'Общественная жизнь': widget.theme12.toDouble(),
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: '12 сфер жизни итог'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 12),
              PieChart(
                dataMap: data,
                animationDuration: const Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: getWidth(context) / 2,
                colorList: const [
                  AppColors.black,
                  AppColors.blue,
                  AppColors.color00DDB5,
                  AppColors.color00FFFFLigtBlue,
                  AppColors.color0180F5BlueDark,
                  AppColors.color049212Red,
                  AppColors.color05FF00LightGreen,
                  AppColors.color333333Grey,
                  AppColors.color38B6FFBLue,
                  AppColors.color4200FFBl,
                  AppColors.colorDADADALightGrey,
                  AppColors.colorF0912FFDartBLue,
                ],
                initialAngleInDegree: 0,
                chartType: ChartType.disc,
                legendOptions: const LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.top,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: const ChartValuesOptions(
                  showChartValueBackground: false,
                  showChartValues: true,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: true,
                  decimalPlaces: 0,
                ),
              ),
              const SizedBox(height: 44),
              Text(
                'Отношения: ${widget.theme1} баллов',
                style: AppTextStyles.s19W400(),
              ),
              const SizedBox(height: 12),
              Text(
                'Дружба: ${widget.theme2} баллов',
                style: AppTextStyles.s19W400(),
              ),
              const SizedBox(height: 12),
              Text(
                'Приключения: ${widget.theme3} баллов',
                style: AppTextStyles.s19W400(),
              ),
              const SizedBox(height: 12),
              Text(
                'Здоровье и спорт: ${widget.theme4} баллов',
                style: AppTextStyles.s19W400(),
              ),
              const SizedBox(height: 12),
              Text(
                'Обстановка: ${widget.theme5} баллов',
                style: AppTextStyles.s19W400(),
              ),
              const SizedBox(height: 12),
              Text(
                'Интеллектуальная жизнь: ${widget.theme6} баллов',
                style: AppTextStyles.s19W400(),
              ),
              const SizedBox(height: 12),
              Text(
                'Навыки: ${widget.theme7} баллов',
                style: AppTextStyles.s19W400(),
              ),
              const SizedBox(height: 12),
              Text(
                'Духовная жизнь: ${widget.theme8} баллов',
                style: AppTextStyles.s19W400(),
              ),
              const SizedBox(height: 12),
              Text(
                'Карьера: ${widget.theme9} баллов',
                style: AppTextStyles.s19W400(),
              ),
              const SizedBox(height: 12),
              Text(
                'Творчество: ${widget.theme10} баллов',
                style: AppTextStyles.s19W400(),
              ),
              const SizedBox(height: 12),
              Text(
                'Семья: ${widget.theme11} баллов',
                style: AppTextStyles.s19W400(),
              ),
              const SizedBox(height: 12),
              Text(
                'Общественная жизнь: ${widget.theme12} баллов',
                style: AppTextStyles.s19W400(),
              ),
              const SizedBox(height: 44),
            ],
          ),
        ),
      ),
    );
  }
}
