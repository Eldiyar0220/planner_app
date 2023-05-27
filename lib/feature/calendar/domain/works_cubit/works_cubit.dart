import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyz_jubek/feature/calendar/data/models/work_model.dart';

part 'works_state.dart';
part 'works_cubit.freezed.dart';

class WorksCubit extends Cubit<WorksState> {
  WorksCubit() : super(const WorksState.initial());

  getWorks(String date) async {
    emit(const WorksState.loading());
    try {
      final workBox = await Hive.openBox<WorkModel>('workBox');
      List<WorkModel> workList = workBox.values.toList();
      workList.removeWhere((e) => e.date != date);
      emit(WorksState.successGet(List.from(workList)));
    } catch (e) {
      emit(WorksState.error(e.toString()));
    }
  }

  addWorks(WorkModel model) async {
    emit(const WorksState.loading());
    try {
      final workBox = await Hive.openBox<WorkModel>('workBox');
      await workBox.add(model);
      emit(const WorksState.successAdd());
    } catch (e) {
      emit(WorksState.error(e.toString()));
    }
  }

  deleteWorks(int id) async {
    emit(const WorksState.loading());
    try {
      final workBox = await Hive.openBox<WorkModel>('workBox');
      final model = workBox.values.toList().singleWhere((e) => e.id == id);
      await model.delete();
      emit(const WorksState.successAdd());
    } catch (e) {
      emit(WorksState.error(e.toString()));
    }
  }

  complateWorks(int id, bool isCompleted) async {
    try {
      final workBox = await Hive.openBox<WorkModel>('workBox');
      final model = workBox.values.toList().singleWhere((e) => e.id == id);
      model.isComleted = isCompleted;
      await model.save();
    } catch (e) {
      emit(WorksState.error(e.toString()));
    }
  }
}
