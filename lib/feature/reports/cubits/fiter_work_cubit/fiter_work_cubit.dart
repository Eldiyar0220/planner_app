import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyz_jubek/core/components/date_formates.dart';
import 'package:kyz_jubek/feature/calendar/data/models/work_model.dart';

part 'fiter_work_state.dart';
part 'fiter_work_cubit.freezed.dart';

class FiterWorkCubit extends Cubit<FiterWorkState> {
  FiterWorkCubit() : super(const FiterWorkState.loading());

  getFiltredPeriodWorks(
    int dates,
    bool isComplated,
  ) async {
    emit(const FiterWorkState.loading());

    try {
      emit(const FiterWorkState.loading());
      final workBox = await Hive.openBox<WorkModel>('workBox');
      List<WorkModel> workList = workBox.values.toList();

      workList.removeWhere((e) {
        DateTime dateFrom = dateFormatMain.parse(e.date);
        DateTime nowDate = DateTime.now();
        return nowDate.difference(dateFrom).inDays > dates;
      });
      workList.removeWhere((e) => e.isComleted != isComplated);
      emit(FiterWorkState.success(List.from(workList)));
    } catch (e) {
      emit(FiterWorkState.error(e.toString()));
    }
  }
}
