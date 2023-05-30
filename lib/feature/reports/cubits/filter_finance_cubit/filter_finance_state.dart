part of 'filter_finance_cubit.dart';

@freezed
class FilterFinanceState with _$FilterFinanceState {
  const factory FilterFinanceState.loading() = _Loading;
  const factory FilterFinanceState.error(String error) = _Error;
  const factory FilterFinanceState.success(List<FinanceModel> model) = _Success;
}
