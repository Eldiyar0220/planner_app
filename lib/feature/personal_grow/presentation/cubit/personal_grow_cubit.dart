import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyz_jubek/feature/personal_grow/data/models/personal_grow_model.dart';
import 'package:kyz_jubek/feature/personal_grow/domain/personal_grow_interactor.dart';

part 'personal_grow_state.dart';
part 'personal_grow_cubit.freezed.dart';

class PersonalGrowCubit extends Cubit<PersonalGrowState> {
  PersonalGrowCubit(this._interactor)
      : super(const PersonalGrowState.loading());

  Future<void> getFilms() async {
    try {
      emit(const PersonalGrowState.loading());
      emit(
        PersonalGrowState.success(
          films: await _interactor.getFilms(),
          books: await _interactor.getBooks(),
          country: await _interactor.getCountry(),
        ),
      );
    } catch (e) {
      emit(const PersonalGrowState.error());
    }
  }

  final PersonalGrowInteractor _interactor;
}
