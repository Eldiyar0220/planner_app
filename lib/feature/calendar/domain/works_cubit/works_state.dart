part of 'works_cubit.dart';

@freezed
class WorksState with _$WorksState {
  const factory WorksState.initial() = _Initial;
  const factory WorksState.loading() = _Loading;
  const factory WorksState.error(String error) = _Error;
  const factory WorksState.successGet(List<WorkModel> model) = _SuccessGet;
  const factory WorksState.successAdd() = _SuccessAdd;
}
