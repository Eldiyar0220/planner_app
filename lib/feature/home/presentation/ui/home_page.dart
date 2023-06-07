import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyz_jubek/core/components/custom_app_bar.dart';
import 'package:kyz_jubek/core/components/date_formates.dart';
import 'package:kyz_jubek/core/components/main_simple_button.dart';
import 'package:kyz_jubek/core/components/styled_toasts.dart';
import 'package:kyz_jubek/feature/add_note/add_note_main_screen.dart';
import 'package:kyz_jubek/feature/home/data/smile_cubit/smile_cubit.dart';
import 'package:kyz_jubek/feature/home/domain/smile_model.dart';
import 'package:kyz_jubek/feature/home/presentation/widgets/show_feel_dialog.dart';
import 'package:kyz_jubek/feature/info/info_screen.dart';
import 'package:kyz_jubek/feature/reports/report_main_screen.dart';
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
    Timer(const Duration(milliseconds: 220), () {
      isShowQrCode.value = true;
    });
  }

  String date = dateFormatMain.format(DateTime.now());
  DateTime feelDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final mQu = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => SmileCubit(),
      child: Scaffold(
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
                  height: mQu * 0.4,
                  width: 205,
                  alignment: Alignment.center,
                  decoration: AppDecorations.defaultDeco(
                    color: AppColors.color38B6FFBLue,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Text(
                        date,
                        style: AppTextStyles.s18W400(
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      MainSimpleButton(
                        onTap: () async {
                          final DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2122),
                          );

                          if (selectedDate != null) {
                            setState(() {
                              date = dateFormatMain.format(selectedDate);
                              feelDate = selectedDate;
                            });
                          }
                        },
                        title: 'Выбрать дату',
                        height: 50,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 550),
                  height: isShowQrCode.value ? mQu * 0.9 : 0,
                  width: mQu,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                    color: AppColors.color38B6FFBLue,
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddNoteMainScreen(),
                              ),
                            );
                          },
                          title: 'Добавить запись',
                        ),
                        const SizedBox(height: 10.0),
                        BlocConsumer<SmileCubit, SmileState>(
                          listener: (context, state) {
                            state.whenOrNull(
                              successAdd: () {
                                showSuccessSnackBar('Сохранен!');
                              },
                            );
                          },
                          builder: (context, state) {
                            return MainSimpleButton(
                              onTap: () async {
                                final smileBox =
                                    await Hive.openBox<SmileModel>('smiles');
                                final smiles = smileBox.values.toList();
                                final dates = smiles
                                    .map<DateTime>((e) => e.date)
                                    .toList();
                                final int? grade =
                                    await showFeelDialog(context);
                                if (grade != null) {
                                  if (dates.contains(feelDate)) {
                                    context
                                        .read<SmileCubit>()
                                        .addSmiles(grade, feelDate);
                                  } else {
                                    showErrorSnackBar(
                                      'Сегодня вы уже добавляли настроение!',
                                    );
                                  }
                                }
                              },
                              title: 'Как вы себя чувствуете?',
                            );
                          },
                        ),
                        const SizedBox(height: 10.0),
                        MainSimpleButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ReportMainScreen(),
                              ),
                            );
                          },
                          title: 'Подвести итоги',
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
