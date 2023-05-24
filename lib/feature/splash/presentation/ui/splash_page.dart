import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/constants/app_text_constants.dart';
import 'package:kyz_jubek/core/local_storage/local_storage.dart';
import 'package:kyz_jubek/feature/auth/presentation/ui/auth_page.dart';
import 'package:kyz_jubek/feature/navigation/presentation/ui/navigation_page.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => checkUser(),
    );
  }

  checkUser() async {
    final isLogged = await LocalStorage.readData(SharedKeys.authEmail);

    if (isLogged != null) {
      funcToPush(const BottomNavigatorPage(), '/navigation');
    } else {
      funcToPush(const AuthPage(), '/auth');
    }
  }

  funcToPush(Widget page, String routeName) {
    Future.delayed(const Duration(milliseconds: 2400), () {
      Navigator.pushReplacement(
        context,
        FadeInRoute(
          page,
          routeName,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(height: 20.0),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Multi Millionaire!',
                  textStyle: AppTextStyles.s18W400(
                    color: AppColors.black,
                  ),
                  speed: const Duration(milliseconds: 60),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 100),
            ),
          ],
        ),
      ),
    );
  }
}

class FadeInRoute extends PageRouteBuilder {
  final Widget page;
  final String routeName;
  FadeInRoute(this.page, this.routeName)
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 800),
        );
}
