import 'dart:developer';

import 'package:kyz_jubek/core/constants/app_text_constants.dart';
import 'package:kyz_jubek/core/local_storage/local_storage.dart';
import 'package:kyz_jubek/feature/auth/data/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kyz_jubek/feature/auth/data/user_model.dart';

class AuthUseCase {
  GetAuthRepo getAuthRepo;
  AuthUseCase(this.getAuthRepo);
  Future<UserModel> setUser(GoogleSignInAuthentication googleAuth) async {
    OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    UserModel user = UserModel(
      email: userCredential.user!.email!,
      name: userCredential.user!.displayName!,
      image: userCredential.user!.photoURL!,
      uid: userCredential.user!.uid,
      date: DateTime.now().toString(),
    );

    UserModel? userFrom = await getAuthRepo.setUser(user);

    if (userFrom != null) {
      user = userFrom;
    }
    log('EDU1 ${user.email}');
    log('EDU1 ${user.name}');
    log('EDU1 ${user.uid}');

    LocalStorage.saveData(SharedKeys.authEmail, user.email);
    LocalStorage.saveData(SharedKeys.name, user.name);
    LocalStorage.saveData(SharedKeys.uid, user.uid);

    return user;
  }
}
