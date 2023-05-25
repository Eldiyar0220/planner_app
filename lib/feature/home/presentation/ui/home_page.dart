import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/custom_app_bar.dart';
import 'package:kyz_jubek/core/components/date_formates.dart';
import 'package:kyz_jubek/core/components/main_simple_button.dart';
import 'package:kyz_jubek/feature/home/presentation/widgets/show_feel_dialog.dart';
import 'package:kyz_jubek/feature/info/info_screen.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_decoration.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier isShowQrCode = ValueNotifier<bool>(false);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer(const Duration(milliseconds: 350), () {
      isShowQrCode.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mQu = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(
        title: 'Главное меню',
        isCanPop: false,
      ),
      body: ValueListenableBuilder(
        valueListenable: isShowQrCode,
        builder: (context, _, __) {
          return Column(
            children: [
              const Spacer(),
              Container(
                height: 205,
                width: 205,
                alignment: Alignment.center,
                decoration: AppDecorations.defaultDeco(
                    color: AppColors.color38B6FFBLue),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Text(
                      dateFormatMain.format(DateTime.now()),
                      style: AppTextStyles.s18W400(
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    MainSimpleButton(
                      onTap: () {},
                      title: 'Привычка на сегодня',
                      height: 30,
                    ),
                    const SizedBox(height: 10.0),
                    MainSimpleButton(
                      onTap: () {},
                      title: 'Дела',
                      height: 30,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              AnimatedContainer(
                duration: const Duration(milliseconds: 750),
                height: isShowQrCode.value ? mQu * 0.7 : 0,
                // curve: Curves.fastEaseInToSlowEaseOut,
                width: mQu,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  ),
                  color: AppColors.color38B6FFBLue,
                ),
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    children: [
                      MainSimpleButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const InfoScreen(),
                            ),
                          );
                        },
                        title: 'Лента полезной информации',
                      ),
                      const SizedBox(height: 10.0),
                      MainSimpleButton(
                        onTap: () async {
                          await showFeelDialog(context);
                        },
                        title: 'Как вы себы чувствуете?',
                      ),
                      const SizedBox(height: 10.0),
                      MainSimpleButton(
                        onTap: () {},
                        title: 'Подвести итоги',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
