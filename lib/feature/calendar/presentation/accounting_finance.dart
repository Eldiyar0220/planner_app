import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/date_formates.dart';
import 'package:kyz_jubek/core/components/main_simple_button.dart';
import 'package:kyz_jubek/feature/calendar/data/table_model.dart';
import 'package:kyz_jubek/feature/calendar/domain/calendar_interactor.dart';
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
  List<TableModel> listExpenses = [];

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Accounting'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            Text(
              'Доход на ${doxod.isNotEmpty ? dateFormatMain.format(doxod.first.date) : '__ /__ /____'}',
              style: AppTextStyles.s22W700(),
            ),
            const SizedBox(height: 10.0),
            TableBodyWidget(
              onTap: (model) {
                doxod.remove(model);
                setState(() {});
              },
              tableName: 'finance',
              title2: 'Доход',
              children1: doxod,
            ),
            const SizedBox(height: 20.0),
            MainSimpleButton(
              onTap: () => ShowDialogWidget.dialogBuilder(
                context,
                title: 'Добавить доход',
                keyboardType: TextInputType.number,
              ).then((value) async {
                if (value.isNotEmpty) {
                  final result = TableModel(
                    date: DateTime.now(),
                    title2: value,
                    title3: 'ssdfsdfsdfsdf684784574875',
                  );

                  doxod.add(result);
                  setState(() {});

                  await CalendarInteractorImpl.setDeals(
                    tableModel: result,
                    tableName: 'finance',
                  );
                }
              }),
              title: 'Добавить доход',
            ),
            const SizedBox(height: 50.0),
            Text(
              'Расход на ${listExpenses.isNotEmpty ? dateFormatMain.format(listExpenses.first.date) : '__ /__ /____'}',
              style: AppTextStyles.s22W700(),
            ),
            const SizedBox(height: 10.0),
            TableBodyWidget(
              onTap: (model) {
                listExpenses.remove(model);
                setState(() {});
              },
              tableName: 'expenses',
              title2: 'Расход',
              children1: listExpenses,
            ),
            const SizedBox(height: 20.0),
            MainSimpleButton(
              onTap: () => ShowDialogWidget.dialogBuilder(
                context,
                title: 'Добавить расход',
                keyboardType: TextInputType.number,
              ).then((value) async {
                if (value.isNotEmpty) {
                  final result = TableModel(
                    date: DateTime.now(),
                    title2: value,
                    title3: 'empty',
                  );

                  listExpenses.add(result);
                  setState(() {});

                  await CalendarInteractorImpl.setDeals(
                    tableModel: result,
                    tableName: 'expenses',
                  );
                }
              }),
              title: 'Добавить расход',
            ),
          ],
        ),
      ),
    );
  }
}
