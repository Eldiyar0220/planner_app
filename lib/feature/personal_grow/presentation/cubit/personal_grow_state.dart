part of 'personal_grow_cubit.dart';

@freezed
class PersonalGrowState with _$PersonalGrowState {
  const factory PersonalGrowState.success({
    required List<PersonalGrowModel> books,
    required List<PersonalGrowModel> films,
    required List<PersonalGrowModel> country,
  }) = _Success;
  const factory PersonalGrowState.loading() = _Loading;
  const factory PersonalGrowState.error() = _Error;
}
