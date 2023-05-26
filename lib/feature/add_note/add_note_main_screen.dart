import 'package:flutter/material.dart';
import 'package:kyz_jubek/feature/reports/widgets/finance_tab_screen.dart';
import 'package:kyz_jubek/feature/reports/widgets/smile_tab_screen.dart';
import 'package:kyz_jubek/feature/reports/widgets/works_tab_screen.dart';
import 'package:kyz_jubek/themes/app_colors.dart';

class AddNoteMainScreen extends StatelessWidget {
  const AddNoteMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.color38B6FFBLue,
          title: const Text('Добавить запись'),
          bottom: const TabBar(
            dividerColor: Colors.transparent,
            tabs: <Widget>[
              Tab(text: 'Благодарность'),
              Tab(text: 'Идеи'),
              Tab(text: 'Победы'),
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