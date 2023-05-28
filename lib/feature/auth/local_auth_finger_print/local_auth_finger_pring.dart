import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/main_simple_button.dart';
import 'package:kyz_jubek/core/local_storage/local_storage.dart';
import 'package:kyz_jubek/feature/navigation/presentation/ui/navigation_page.dart';
import 'package:kyz_jubek/feature/splash/presentation/ui/splash_page.dart';
import 'package:kyz_jubek/themes/app_decoration.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class LocalAuthFingerPrintPage extends StatelessWidget {
  const LocalAuthFingerPrintPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: AppDecorations.defaultDeco(color: Colors.grey),
              child: Image.asset('assets/images/logo.png'),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Чтобы не вводить пароль, Включите отпечаток пальца',
              style: AppTextStyles.s16W500(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Text(
              'Включить?',
              style: AppTextStyles.s16W500(),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                MainSimpleButton(
                  onTap: () {
                    LocalStorage.saveData('finger', false);
                    func(context);
                  },
                  title: 'Нет',
                  width: 110,
                ),
                const Spacer(),
                MainSimpleButton(
                  onTap: () {
                    LocalStorage.saveData('finger', true);
                    func(context);
                  },
                  title: 'Да',
                  width: 110,
                ),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  func(BuildContext context) {
    Navigator.pushReplacement(
      context,
      FadeInRoute(
        const BottomNavigatorPage(),
        '/navigation',
      ),
    );
  }
}
