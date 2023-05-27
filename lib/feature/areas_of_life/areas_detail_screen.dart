import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/custom_app_bar.dart';
import 'package:kyz_jubek/core/components/custom_button.dart';
import 'package:kyz_jubek/core/components/custom_text_field.dart';
import 'package:kyz_jubek/core/components/styled_toasts.dart';
import 'package:kyz_jubek/core/local_storage/local_storage.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class AreasDetailScreen extends StatefulWidget {
  const AreasDetailScreen({
    super.key,
    required this.title,
    required this.qw1,
    required this.qw2,
    required this.qw3,
    required this.qw4,
    required this.qw5,
    required this.ref1,
    required this.ref2,
    required this.ref3,
    required this.ref4,
    required this.ref5,
  });
  final String title;
  final String qw1;
  final String qw2;
  final String qw3;
  final String qw4;
  final String qw5;
  final String ref1;
  final String ref2;
  final String ref3;
  final String ref4;
  final String ref5;

  @override
  State<AreasDetailScreen> createState() => _AreasDetailScreenState();
}

class _AreasDetailScreenState extends State<AreasDetailScreen> {
  late final controller1 = TextEditingController(text: widget.qw1);
  late final controller2 = TextEditingController(text: widget.qw2);
  late final controller3 = TextEditingController(text: widget.qw3);
  late final controller4 = TextEditingController(text: widget.qw4);
  late final controller5 = TextEditingController(text: widget.qw5);

  late String qwestion1 = widget.qw1;
  late String qwestion2 = widget.qw2;
  late String qwestion3 = widget.qw3;
  late String qwestion4 = widget.qw4;
  late String qwestion5 = widget.qw5;

  bool isChanged() =>
      qwestion1 != widget.qw1 ||
      qwestion2 != widget.qw2 ||
      qwestion3 != widget.qw3 ||
      qwestion4 != widget.qw4 ||
      qwestion5 != widget.qw5;

  bool isAllSelected() =>
      qwestion1.isNotEmpty &&
      qwestion2.isNotEmpty &&
      qwestion3.isNotEmpty &&
      qwestion4.isNotEmpty &&
      qwestion5.isNotEmpty;
  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    super.dispose();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 12),
              Text(
                '1-вопрос:',
                style: AppTextStyles.s16W400(),
              ),
              const SizedBox(height: 5),
              CustomTextField(
                hintText: '',
                controller: controller1,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (int.parse(value) > 20) {
                      controller1.text = '20';
                      setState(() {
                        qwestion1 = '20';
                      });
                      controller1.selection = TextSelection.fromPosition(
                        TextPosition(offset: controller1.text.length),
                      );
                    } else {
                      setState(() {
                        qwestion1 = value;
                      });
                    }
                  } else {
                    setState(() {
                      qwestion1 = value;
                    });
                  }
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              Text(
                '2-вопрос:',
                style: AppTextStyles.s16W400(),
              ),
              const SizedBox(height: 5),
              CustomTextField(
                hintText: '',
                controller: controller2,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (int.parse(value) > 20) {
                      controller2.text = '20';
                      setState(() {
                        qwestion2 = '20';
                      });
                      controller2.selection = TextSelection.fromPosition(
                        TextPosition(offset: controller2.text.length),
                      );
                    } else {
                      setState(() {
                        qwestion2 = value;
                      });
                    }
                  } else {
                    setState(() {
                      qwestion2 = value;
                    });
                  }
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              Text(
                '3-вопрос:',
                style: AppTextStyles.s16W400(),
              ),
              const SizedBox(height: 5),
              CustomTextField(
                hintText: '',
                controller: controller3,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (int.parse(value) > 20) {
                      controller3.text = '20';
                      setState(() {
                        qwestion3 = '20';
                      });
                      controller3.selection = TextSelection.fromPosition(
                        TextPosition(offset: controller3.text.length),
                      );
                    } else {
                      setState(() {
                        qwestion3 = value;
                      });
                    }
                  } else {
                    setState(() {
                      qwestion3 = value;
                    });
                  }
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              Text(
                '4-вопрос:',
                style: AppTextStyles.s16W400(),
              ),
              const SizedBox(height: 5),
              CustomTextField(
                hintText: '',
                controller: controller4,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (int.parse(value) > 20) {
                      controller4.text = '20';
                      setState(() {
                        qwestion4 = '20';
                      });
                      controller4.selection = TextSelection.fromPosition(
                        TextPosition(offset: controller4.text.length),
                      );
                    } else {
                      setState(() {
                        qwestion4 = value;
                      });
                    }
                  } else {
                    setState(() {
                      qwestion4 = value;
                    });
                  }
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              Text(
                '5-вопрос:',
                style: AppTextStyles.s16W400(),
              ),
              const SizedBox(height: 5),
              CustomTextField(
                hintText: '',
                controller: controller5,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (int.parse(value) > 20) {
                      controller5.text = '20';
                      setState(() {
                        qwestion5 = '20';
                      });
                      controller5.selection = TextSelection.fromPosition(
                        TextPosition(offset: controller5.text.length),
                      );
                    } else {
                      setState(() {
                        qwestion5 = value;
                      });
                    }
                  } else {
                    setState(() {
                      qwestion5 = value;
                    });
                  }
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 25),
              CustomButton(
                isLoading: isLoading,
                color: widget.qw1.isEmpty && isAllSelected() ||
                        widget.qw1.isNotEmpty && isChanged()
                    ? null
                    : AppColors.color38B6FFBLue.withOpacity(0.5),
                radius: 8,
                text: 'Завершить',
                onPressed: () async {
                  if (widget.qw1.isNotEmpty) {
                    if (isChanged()) {
                      setState(() {
                        isLoading = true;
                      });
                      await LocalStorage.saveData(widget.ref1, qwestion1);
                      await LocalStorage.saveData(widget.ref2, qwestion2);
                      await LocalStorage.saveData(widget.ref3, qwestion3);
                      await LocalStorage.saveData(widget.ref4, qwestion4);
                      await LocalStorage.saveData(widget.ref5, qwestion5);
                      setState(() {
                        isLoading = false;
                      });
                      showSuccessSnackBar('Успешно изменен!');
                      Navigator.pop(context);
                    }
                  } else {
                    if (isAllSelected()) {
                      setState(() {
                        isLoading = true;
                      });
                      await LocalStorage.saveData(widget.ref1, qwestion1);
                      await LocalStorage.saveData(widget.ref2, qwestion2);
                      await LocalStorage.saveData(widget.ref3, qwestion3);
                      await LocalStorage.saveData(widget.ref4, qwestion4);
                      await LocalStorage.saveData(widget.ref5, qwestion5);
                      setState(() {
                        isLoading = false;
                      });
                      showSuccessSnackBar('Успешно сохранен!');
                      Navigator.pop(context);
                    } else {
                      showErrorSnackBar('Заполните все поля');
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
