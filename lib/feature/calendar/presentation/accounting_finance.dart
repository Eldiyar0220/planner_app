import 'package:flutter/material.dart';
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
  List<TableModel> deals = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final result = await CalendarInteractorImpl.getDeals('finance');
        if (result.isNotEmpty) {
          doxod = result;
        }
        final resultDeals = await CalendarInteractorImpl.getDeals('deals');
        if (resultDeals.isNotEmpty) {
          deals = resultDeals;
        }
        setState(() {});
      },
    );
  }

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
              ).then((value) async {
                if (value.isNotEmpty) {
                  final result = TableModel(
                    date: DateTime.now(),
                    title2: value,
                    title3: 'empty',
                  );

                  setState(() {});
                  doxod.add(result);

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
              ).then((value) async {
                if (value.isNotEmpty) {
                  final result = TableModel(
                    date: DateTime.now(),
                    title2: value,
                    title3: 'empty',
                  );

                  deals.add(result);
                  setState(() {});

                  await CalendarInteractorImpl.setDeals(
                    tableModel: result,
                    tableName: 'deals',
                  );
                }
              }),
              title: 'Добавить доход',
            ),
          ],
        ),
      ),
    );
  }
}
