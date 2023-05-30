import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyz_jubek/core/components/date_formates.dart';
import 'package:kyz_jubek/feature/calendar/data/models/finance_model.dart';

part 'filter_finance_state.dart';
part 'filter_finance_cubit.freezed.dart';

class FilterFinanceCubit extends Cubit<FilterFinanceState> {
  FilterFinanceCubit() : super(const FilterFinanceState.loading());

  getFiltredPeriodFinances(
    int dates,
    String type,
  ) async {
    emit(const FilterFinanceState.loading());

    try {
      emit(const FilterFinanceState.loading());
      final workBox = await Hive.openBox<FinanceModel>('financeBox');
      List<FinanceModel> workList = workBox.values.toList();

      workList.removeWhere((e) {
        DateTime dateFrom = dateFormatMain.parse(e.date);
        DateTime nowDate = DateTime.now();
        return nowDate.difference(dateFrom).inDays > dates;
      });
      workList.removeWhere((e) => e.type != type);
      emit(FilterFinanceState.success(List.from(workList)));
    } catch (e) {
      emit(FilterFinanceState.error(e.toString()));
    }
  }
}
