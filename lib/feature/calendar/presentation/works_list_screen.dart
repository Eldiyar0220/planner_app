import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyz_jubek/core/components/app_error_text.dart';
import 'package:kyz_jubek/core/components/app_indicator.dart';
import 'package:kyz_jubek/core/components/custom_app_bar.dart';
import 'package:kyz_jubek/core/components/custom_button.dart';
import 'package:kyz_jubek/feature/calendar/data/models/work_model.dart';
import 'package:kyz_jubek/feature/calendar/domain/works_cubit/works_cubit.dart';
import 'package:kyz_jubek/feature/calendar/presentation/widgets/items_widget.dart';
import 'package:kyz_jubek/feature/calendar/presentation/widgets/show_add_dialog.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class WorksListScreen extends StatefulWidget {
  const WorksListScreen({super.key, required this.date});
  final String date;

  @override
  State<WorksListScreen> createState() => _WorksListScreenState();
}

class _WorksListScreenState extends State<WorksListScreen> {
  @override
  void initState() {
    context.read<WorksCubit>().getWorks(widget.date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Список дел'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text(
                'Список дел на ${widget.date}',
                style: AppTextStyles.s16W400(),
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
                              itemBuilder: (context, index) => ItemsWidget(
                                model: model[index],
                              ),
                            ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              BlocConsumer<WorksCubit, WorksState>(
                listener: (context, state) {
                  state.whenOrNull(
                    successAdd: () {
                      context.read<WorksCubit>().getWorks(widget.date);
                    },
                  );
                },
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CustomButton(
                      radius: 8,
                      text: 'Добавить дело',
                      onPressed: () async {
                        final value = await showAddDialog(context, 'дело');
                        if (value.isNotEmpty) {
                          final int id = DateTime.now().millisecondsSinceEpoch;
                          context.read<WorksCubit>().addWorks(
                                WorkModel(
                                  date: widget.date,
                                  value: value,
                                  id: id,
                                  isComleted: false,
                                ),
                              );
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
