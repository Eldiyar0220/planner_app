part of 'fiter_work_cubit.dart';

@freezed
class FiterWorkState with _$FiterWorkState {
  const factory FiterWorkState.loading() = _Loading;
  const factory FiterWorkState.error(String error) = _Error;
  const factory FiterWorkState.success(List<WorkModel> model) = _Success;
}
