import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:kyz_jubek/feature/calendar/data/models/finance_model.dart';

part 'finance_state.dart';
part 'finance_cubit.freezed.dart';

class FinanceCubit extends Cubit<FinanceState> {
  FinanceCubit() : super(const FinanceState.initial());

  getFinances(String date, String type) async {
    emit(const FinanceState.loading());
    try {
      final financeBox = await Hive.openBox<FinanceModel>('financeBox');
      List<FinanceModel> financeList = financeBox.values.toList();
      financeList.removeWhere((e) => e.date != date);
      financeList.removeWhere((e) => e.type != type);
      emit(FinanceState.successGet(financeList));
    } catch (e) {
      emit(FinanceState.error(e.toString()));
    }
  }

  addFinances(FinanceModel model) async {
    emit(const FinanceState.loading());
    try {
      final financeBox = await Hive.openBox<FinanceModel>('financeBox');
      await financeBox.add(model);
      emit(const FinanceState.successAdd());
    } catch (e) {
      emit(FinanceState.error(e.toString()));
    }
  }

  deleteFinances(int id) async {
    emit(const FinanceState.loading());
    try {
      final financeBox = await Hive.openBox<FinanceModel>('financeBox');
      final model = financeBox.values.toList().singleWhere((e) => e.id == id);
      await model.delete();
      emit(const FinanceState.successAdd());
    } catch (e) {
      emit(FinanceState.error(e.toString()));
    }
  }
}
