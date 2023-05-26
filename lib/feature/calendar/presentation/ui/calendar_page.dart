import 'package:flutter/material.dart';

import 'package:kyz_jubek/core/components/custom_app_bar.dart';
import 'package:kyz_jubek/core/components/date_formates.dart';
import 'package:kyz_jubek/feature/calendar/data/table_model.dart';
import 'package:kyz_jubek/feature/calendar/presentation/accounting_finance.dart';
import 'package:kyz_jubek/feature/calendar/presentation/list_deals_page.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_decoration.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Calendare',
        isCanPop: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            Text(
              'Сегоднящняя дата',
              style: AppTextStyles.s18W400(
                color: Colors.black,
              ),
            ),
            Text(
              dateFormatMain.format(DateTime.now()),
              style: AppTextStyles.s18W400(
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30.0),
            Row(
              children: [
                _CalendarContainerWidget(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountingFinance(),
                      ),
                    );
                  },
                  title: 'Учет \nфинансов',
                ),
                const Spacer(),
                _CalendarContainerWidget(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListDealsPage(),
                      ),
                    );
                  },
                  title: 'Список \nдел',
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Container(
              decoration: AppDecorations.defaultDeco(
                color: AppColors.color38B6FFBLue,
              ),
              padding: const EdgeInsets.only(
                right: 16,
                left: 16,
                top: 20,
                bottom: 15,
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Список дел на __/__/_____',
                    style: AppTextStyles.s24W300(),
                  ),
                  const SizedBox(height: 10.0),
                  TableBodyWidget(
                    heightOfListView: MediaQuery.of(context).size.height * 0.4,
                    children1: const [],
                    children2: const [],
                    children3: const [],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TableBodyWidget extends StatefulWidget {
  const TableBodyWidget({
    Key? key,
    this.title1 = 'Дата',
    this.title2 = 'Дело',
    this.title3 = 'Заметки',
    required this.children1,
    required this.children2,
    required this.children3,
    this.heightOfListView = 130,
  }) : super(key: key);

  final String title1;
  final String title2;
  final String title3;

  final List<TableModel> children1;
  final List<TableModel> children2;
  final List<TableModel> children3;
  final double heightOfListView;

  @override
  State<TableBodyWidget> createState() => _TableBodyWidgetState();
}

class _TableBodyWidgetState extends State<TableBodyWidget> {
  ScrollController controller1 = ScrollController();
  ScrollController controller2 = ScrollController();
  ScrollController controller3 = ScrollController();

  @override
  void initState() {
    super.initState();
    controller1.addListener(() {
      controller2.jumpTo(controller1.offset);
      controller3.jumpTo(controller1.offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.white,
        border: Border.all(),
      ),
      padding: const EdgeInsets.only(
        bottom: 5,
      ),
      child: Table(
        border: TableBorder.symmetric(
          inside: const BorderSide(),
        ),
        children: [
          TableRow(
            children: [
              _TableTitleWidget(title: widget.title1),
              _TableTitleWidget(title: widget.title2),
              _TableTitleWidget(title: widget.title3),
            ],
          ),
          TableRow(
            children: [
              SizedBox(
                height: widget.heightOfListView,
                child: ListView.separated(
                  controller: controller1,
                  key: const PageStorageKey('Value'),
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(
                    left: 2,
                    top: 5,
                    bottom: 5,
                  ),
                  itemCount: widget.children1.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10.0),
                  itemBuilder: (BuildContext context, int index) => Text(
                      '${index + 1}. ${dateFormatMain.format(widget.children1[index].date)}'),
                ),
              ),
              SizedBox(
                height: widget.heightOfListView,
                child: ListView.separated(
                  controller: controller2,
                  key: const PageStorageKey('Value'),
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(
                    right: 10,
                    left: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  itemCount: widget.children2.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10.0),
                  itemBuilder: (BuildContext context, int index) =>
                      Text(widget.children2[index].title2),
                ),
              ),
              SizedBox(
                height: widget.heightOfListView,
                child: ListView.separated(
                  controller: controller3,
                  key: const PageStorageKey('Value'),
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(
                    right: 10,
                    left: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  itemCount: widget.children3.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10.0),
                  itemBuilder: (BuildContext context, int index) =>
                      Text(widget.children3[index].title3),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _TableTitleWidget extends StatelessWidget {
  const _TableTitleWidget({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: AppTextStyles.s14W600(),
      ),
    );
  }
}

class _CalendarContainerWidget extends StatelessWidget {
  const _CalendarContainerWidget({
    required this.onTap,
    required this.title,
  });

  final Function() onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.width * 0.28,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: AppDecorations.defaultDeco(
          color: AppColors.color38B6FFBLue,
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.s15W600(),
        ),
      ),
    );
  }
}
