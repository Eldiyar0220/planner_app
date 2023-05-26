import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/main_simple_button.dart';
import 'package:kyz_jubek/core/local_storage/local_storage.dart';
import 'package:kyz_jubek/feature/calendar/data/model.dart';
import 'package:kyz_jubek/feature/calendar/presentation/ui/calendar_page.dart';
import 'package:kyz_jubek/feature/calendar/widgets/show_dialog_widget.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class AccountingFinance extends StatefulWidget {
  const AccountingFinance({super.key});

  @override
  State<AccountingFinance> createState() => _AccountingFinanceState();
}

class _AccountingFinanceState extends State<AccountingFinance> {
  List<TableModel> doxod = [];
  List<TableModel> deals = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Accounting'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            Text(
              'Доход на __ /__ /_____',
              style: AppTextStyles.s22W700(),
            ),
            const SizedBox(height: 10.0),
            TableBodyWidget(
              title2: 'Доход',
              children1: doxod,
              children2: doxod,
              children3: doxod,
            ),
            const SizedBox(height: 20.0),
            MainSimpleButton(
              onTap: () => ShowDialogWidget.dialogBuilder(
                context,
                title: 'Добавить дело',
              ).then((value) {
                if (value.isNotEmpty) {
                  final result = TableModel(
                    date: DateTime.now(),
                    title2: value,
                    title3: 'empty',
                  );

                  doxod.add(result);
                  setState(() {});

                  LocalStorage.saveData('doxod', doxod);
                }
              }),
              title: 'Добавить доход',
            ),
            const Spacer(),
            Text(
              'Расход на __ /__ /_____',
              style: AppTextStyles.s22W700(),
            ),
            const SizedBox(height: 10.0),
            TableBodyWidget(
              title2: 'Доход',
              children1: deals,
              children2: deals,
              children3: deals,
            ),
            const SizedBox(height: 20.0),
            MainSimpleButton(
              onTap: () => ShowDialogWidget.dialogBuilder(
                context,
                title: 'Добавить дело',
              ).then((value) {
                if (value.isNotEmpty) {
                  final result = TableModel(
                    date: DateTime.now(),
                    title2: value,
                    title3: 'empty',
                  );

                  deals.add(result);
                  setState(() {});

                  LocalStorage.saveData('deals', deals);
                }
              }),
              title: 'Добавить доход',
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
