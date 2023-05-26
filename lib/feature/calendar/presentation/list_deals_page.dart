import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/date_formates.dart';
import 'package:kyz_jubek/core/components/main_simple_button.dart';
import 'package:kyz_jubek/feature/calendar/data/table_model.dart';
import 'package:kyz_jubek/feature/calendar/domain/calendar_interactor.dart';
import 'package:kyz_jubek/feature/calendar/presentation/ui/calendar_page.dart';
import 'package:kyz_jubek/feature/calendar/widgets/show_dialog_widget.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class ListDealsPage extends StatefulWidget {
  const ListDealsPage({super.key});

  @override
  State<ListDealsPage> createState() => _ListDealsPageState();
}

class _ListDealsPageState extends State<ListDealsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final result = await CalendarInteractorImpl.getDeals('listDeals');
        if (result.isNotEmpty) {
          listDeals = result;
          setState(() {});
        }
      },
    );
  }

  List<TableModel> listDeals = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('List Deals'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Column(
          children: [
            Text(
              'Дела на ${listDeals.isNotEmpty ? dateFormatMain.format(listDeals.first.date) : '__ /__ /____'}',
              style: AppTextStyles.s22W700(),
            ),
            const SizedBox(height: 10.0),
            TableBodyWidget(
              onTap: (model) {
                setState(() {});
                listDeals.remove(model);
              },
              tableName: 'listDeals',
              heightOfListView: MediaQuery.of(context).size.height * 0.65,
              children1: listDeals,
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

                  listDeals.add(result);
                  setState(() {});
                  await CalendarInteractorImpl.setDeals(
                    tableModel: result,
                    tableName: 'listDeals',
                  );
                }
              }),
              title: 'Добавить дело',
            ),
          ],
        ),
      ),
    );
  }
}
