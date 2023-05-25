import 'package:flutter/material.dart';
import 'package:kyz_jubek/feature/reports/widgets/finance_tab_screen.dart';
import 'package:kyz_jubek/feature/reports/widgets/smile_tab_screen.dart';
import 'package:kyz_jubek/feature/reports/widgets/works_tab_screen.dart';
import 'package:kyz_jubek/themes/app_colors.dart';

class ReportMainScreen extends StatelessWidget {
  const ReportMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox.shrink(),
          backgroundColor: AppColors.color38B6FFBLue,
          title: const Text('Отчеты'),
          bottom: const TabBar(
            dividerColor: Colors.transparent,
            tabs: <Widget>[
              Tab(text: 'Дела'),
              Tab(text: 'Финансы'),
              Tab(text: 'Настроение'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            WorksTabScreen(),
            FinanceTabScreen(),
            SmileTabScreen(),
          ],
        ),
      ),
    );
  }
}
