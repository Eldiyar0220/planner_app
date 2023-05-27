import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyz_jubek/feature/auth/authentication/data/auth_repo.dart';
import 'package:kyz_jubek/feature/auth/authentication/domain/auth_use_case.dart';
import 'package:kyz_jubek/feature/auth/authentication/presentation/auth_cubit/auth_cubit.dart';
import 'package:kyz_jubek/feature/calendar/data/models/finance_model.dart';
import 'package:kyz_jubek/feature/calendar/data/models/work_model.dart';
import 'package:kyz_jubek/feature/calendar/data/table_model.dart';
import 'package:kyz_jubek/feature/calendar/domain/works_cubit/works_cubit.dart';
import 'package:kyz_jubek/feature/home/domain/smile_model.dart';
import 'package:kyz_jubek/feature/personal_grow/data/repository/personal_grow_repo.dart';
import 'package:kyz_jubek/feature/personal_grow/domain/personal_grow_interactor.dart';
import 'package:kyz_jubek/feature/splash/presentation/ui/splash_page.dart';
import 'package:kyz_jubek/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  Hive.registerAdapter(TableModelAdapter());
  Hive.registerAdapter(SmileModelAdapter());
  Hive.registerAdapter(FinanceModelAdapter());
  Hive.registerAdapter(WorkModelAdapter());
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
        ),
        RepositoryProvider(
          create: (context) => GetFromFireBaseImpl(),
        ),
        RepositoryProvider(
          create: (context) => PersonalGrowInteractor(
            RepositoryProvider.of<GetFromFireBaseImpl>(context),
          ),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(
              RepositoryProvider.of<AuthUseCase>(context),
            ),
          ),
          BlocProvider(
            create: (context) => WorksCubit(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(splashFactory: NoSplash.splashFactory),
      title: 'Flutter Demo',
      home: const SplashPage(),
    );
  }
}
