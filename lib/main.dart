import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyz_jubek/feature/auth/data/auth_repo.dart';
import 'package:kyz_jubek/feature/auth/domain/auth_use_case.dart';
import 'package:kyz_jubek/feature/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:kyz_jubek/feature/splash/presentation/ui/splash_page.dart';
import 'package:kyz_jubek/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (context) => GetAuthRepoImpl(),
        ),
        RepositoryProvider(
          create: (context) => AuthUseCase(
            RepositoryProvider.of<GetAuthRepoImpl>(context),
          ),
        )
      ],
      child: BlocProvider(
        create: (context) => AuthCubit(
          RepositoryProvider.of<AuthUseCase>(context),
        ),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: SplashPage(),
    );
  }
}
