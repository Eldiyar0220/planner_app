import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyz_jubek/core/components/app_error_text.dart';
import 'package:kyz_jubek/core/components/app_indicator.dart';
import 'package:kyz_jubek/core/components/custom_app_bar.dart';
import 'package:kyz_jubek/core/components/date_formates.dart';
import 'package:kyz_jubek/feature/calendar/domain/works_cubit/works_cubit.dart';
import 'package:kyz_jubek/feature/calendar/presentation/finance_detail_screen.dart';
import 'package:kyz_jubek/feature/calendar/presentation/widgets/calendar_select_widget.dart';
import 'package:kyz_jubek/feature/calendar/presentation/widgets/items_widget.dart';
import 'package:kyz_jubek/feature/calendar/presentation/works_list_screen.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  String date = dateFormatMain.format(DateTime.now());

  @override
  void initState() {
    context.read<WorksCubit>().getWorks(date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Календарь',
        isCanPop: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text(
                date,
                style: AppTextStyles.s16W400(),
              ),
              const SizedBox(height: 12),
              Builder(
                builder: (context) => InkWell(
                  onTap: () async {
                    final DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2122),
                    );

                    if (selectedDate != null) {
                      setState(() {
                        date = dateFormatMain.format(selectedDate);
                      });
                      context.read<WorksCubit>().getWorks(date);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: AppColors.color333333Grey.withOpacity(0.5),
                    child: Text(
                      'Выбрать дату',
                      style: AppTextStyles.s16W400(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Builder(
                builder: (context) => Row(
                  children: [
                    CalendarContainerWidget(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FinanceDetailScreen(date: date),
                            ),
                          );
                        },
                        title: 'Учет финансов'),
                    const SizedBox(width: 12),
                    CalendarContainerWidget(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorksListScreen(date: date),
                          ),
                        );
                        context.read<WorksCubit>().getWorks(date);
                        setState(() {});
                      },
                      title: 'Список дел',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: BlocBuilder<WorksCubit, WorksState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => const AppIndicator(),
                      error: (error) => AppErrorText(error: error),
                      successGet: (model) => model.isEmpty
                          ? const Center(
                              child: Text('У вас нет дел на эту дату'),
                            )
                          : ListView.separated(
                              itemCount: model.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                return ItemsWidget(
                                  model: model[index],
                                );
                              },
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
