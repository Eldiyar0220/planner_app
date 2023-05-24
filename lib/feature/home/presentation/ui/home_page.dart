import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/main_simple_button.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_decoration.dart';

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
      appBar: AppBar(
        title: const Text('Главное меню'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.message),
          ),
        ],
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
                  decoration: AppDecorations.defaultDeco(color: Colors.blue),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      const Text('__/__/___'),
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
                  curve: Curves.fastEaseInToSlowEaseOut,
                  width: mQu,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                    color: AppColors.blue,
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: Column(
                      children: [
                        MainSimpleButton(
                          onTap: () {},
                          title: 'Лента полезной информации',
                        ),
                        const SizedBox(height: 10.0),
                        MainSimpleButton(
                          onTap: () {},
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
          }),
    );
  }
}
