part of 'finance_cubit.dart';

@freezed
class FinanceState with _$FinanceState {
  const factory FinanceState.initial() = _Initial;
  const factory FinanceState.loading() = _Loading;
  const factory FinanceState.error(String error) = _Error;
  const factory FinanceState.successGet(List<FinanceModel> model) = _SuccessGet;
  const factory FinanceState.successAdd() = _SuccessAdd;
}
