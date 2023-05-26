part of 'smile_cubit.dart';

@freezed
class SmileState with _$SmileState {
  const factory SmileState.initial() = _Initial;
  const factory SmileState.loading() = _Loading;
  const factory SmileState.error(String error) = _Error;
  const factory SmileState.successAdd() = _SuccessAdd;
  const factory SmileState.successGet(List<SmileModel> model) = _SuccessGet;

  const SmileState._();
  bool get isLoading => maybeWhen(
        orElse: () => false,
        loading: () => true,
      );
}
