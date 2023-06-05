import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyz_jubek/feature/home/domain/smile_model.dart';

part 'smile_state.dart';
part 'smile_cubit.freezed.dart';

class SmileCubit extends Cubit<SmileState> {
  SmileCubit() : super(const SmileState.initial());

  getSmiles(int duration) async {
    emit(const SmileState.loading());
    try {
      final smileBox = await Hive.openBox<SmileModel>('smiles');
      final smiles = smileBox.values.toList();
      smiles.removeWhere(
        (e) => DateTime.now().difference(e.date).inDays > duration,
      );
      emit(SmileState.successGet(smiles));
    } catch (e) {
      emit(SmileState.error(e.toString()));
    }
  }

  addSmiles(int value , DateTime date) async {
    emit(const SmileState.loading());
    try {
      final smileBox = await Hive.openBox<SmileModel>('smiles');
      await smileBox.add(
        SmileModel(date: date, item: value),
      );
      emit(const SmileState.successAdd());
    } catch (e) {
      emit(SmileState.error(e.toString()));
    }
  }
}
