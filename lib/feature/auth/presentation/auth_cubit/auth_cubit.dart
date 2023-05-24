import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyz_jubek/core/local_storage/local_storage.dart';
import 'package:kyz_jubek/feature/auth/data/user_model.dart';
import 'package:kyz_jubek/feature/auth/domain/auth_use_case.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authUseCase) : super(const AuthState.loading());
  final AuthUseCase authUseCase;

  GoogleSignIn googleSignIn = GoogleSignIn();

  getAuth() async {
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      emit(const AuthState.loading());
      emit(
        AuthState.loaded(
          await authUseCase.setUser(
            await googleUser.authentication,
          ),
        ),
      );
    }
  }

  signOut() async {
    emit(const AuthState.loading());
    await googleSignIn.signOut();
    LocalStorage.clearData();
    emit(const AuthState.singOut());
  }
}
