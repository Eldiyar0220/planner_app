import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/main_simple_button.dart';
import 'package:kyz_jubek/core/local_storage/local_storage.dart';
import 'package:kyz_jubek/feature/calendar/data/model.dart';
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
        LocalStorage.readData('ListDeals').then((result) {
          log('list $result');
        });
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            Text(
              'Расход на __ /__ /_____',
              style: AppTextStyles.s22W700(),
            ),
            const SizedBox(height: 10.0),
            TableBodyWidget(
              heightOfListView: MediaQuery.of(context).size.height * 0.65,
              children1: listDeals,
              children2: listDeals,
              children3: listDeals,
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

                  listDeals.add(result);
                  setState(() {});
                  LocalStorage.readData('ListDeals').then((result) {
                    log('list $result');
                  });
                  // LocalStorage.saveData('ListDeals', listDeals);
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
