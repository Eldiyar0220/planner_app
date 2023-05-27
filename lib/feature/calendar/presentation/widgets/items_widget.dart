import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyz_jubek/feature/calendar/data/models/work_model.dart';
import 'package:kyz_jubek/feature/calendar/domain/works_cubit/works_cubit.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class ItemsWidget extends StatefulWidget {
  const ItemsWidget({
    super.key,
    required this.model,
  });

  final WorkModel model;

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier isCheck = ValueNotifier(widget.model.isComleted);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.color38B6FFBLue,
      ),
      child: ValueListenableBuilder(
          valueListenable: isCheck,
          builder: (context, _, __) {
            return Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.model.value,
                        style: AppTextStyles.s18W400(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.model.date,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                Checkbox(
                  fillColor: MaterialStateProperty.all(Colors.white),
                  checkColor: AppColors.color0180F5BlueDark,
                  value: isCheck.value,
                  onChanged: (value) {
                    setState(() {
                      isCheck.value = value!;
                    });
                    context.read<WorksCubit>().complateWorks(
                          widget.model.id,
                          isCheck.value,
                        );
                    context.read<WorksCubit>().getWorks(widget.model.date);
                  },
                ),
              ],
            );
          }),
    );
  }
}
