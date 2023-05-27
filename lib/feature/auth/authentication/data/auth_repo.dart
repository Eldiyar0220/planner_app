import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kyz_jubek/feature/auth/authentication/data/user_model.dart';

abstract class GetAuthRepo {
  Future<UserModel?> setUser(UserModel model);
}

class GetAuthRepoImpl implements GetAuthRepo {
  @override
  Future<UserModel?> setUser(UserModel model) async {
    CollectionReference firestore =
        FirebaseFirestore.instance.collection('users');
    DocumentSnapshot user = await firestore.doc(model.uid).get();

    if (user.data() == null) {
      await firestore.doc(model.uid).set(model.toJson());
      return null;
    } else {
      return UserModel.fromJson(user);
    }
  }
}
