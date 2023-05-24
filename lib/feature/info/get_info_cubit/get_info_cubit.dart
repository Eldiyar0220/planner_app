import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyz_jubek/feature/info/info_model.dart';

part 'get_info_state.dart';
part 'get_info_cubit.freezed.dart';

class GetInfoCubit extends Cubit<GetInfoState> {
  GetInfoCubit() : super(const GetInfoState.initial()) {
    getInfo();
  }

  getInfo() async {
    emit(const GetInfoState.loading());
    CollectionReference firestore =
        FirebaseFirestore.instance.collection('info');

    try {
      final infoList = await firestore.get();
      List<InfoModel> infos = [];

      for (var e in infoList.docs) {
        infos.add(InfoModel.fromQuerySnapshot(e));
      }
      emit(GetInfoState.success(infos));
    } catch (e) {
      emit(GetInfoState.error(e.toString()));
    }
  }
}
