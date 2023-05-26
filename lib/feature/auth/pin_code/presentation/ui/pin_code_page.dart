import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/loading_indicator.dart';
import 'package:kyz_jubek/core/components/main_simple_button.dart';
import 'package:kyz_jubek/core/local_storage/local_storage.dart';
import 'package:kyz_jubek/feature/auth/authentication/presentation/ui/auth_page.dart';
import 'package:kyz_jubek/feature/navigation/presentation/ui/navigation_page.dart';
import 'package:kyz_jubek/feature/splash/presentation/ui/splash_page.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

enum EnterPintCode { enter, create }

class PinCodePage extends StatefulWidget {
  const PinCodePage({super.key});

  @override
  State<PinCodePage> createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  late TextEditingController controller1;
  String title1 = 'Придумайте код';
  String title2 = 'Для входа в систему введите код';
  late FocusNode focusNode;
  String? installedPinCode;
  ValueNotifier success = ValueNotifier(false);
  EnterPintCode type = EnterPintCode.create;

  @override
  void initState() {
    super.initState();
    controller1 = TextEditingController();
    focusNode = FocusNode();
    Timer(const Duration(milliseconds: 200), () => focusNode.requestFocus());

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final pinCode = await LocalStorage.readData('user');

        if (pinCode == null) {
          installedPinCode = null;
        } else if (pinCode != null) {
          type = EnterPintCode.enter;
          title1 = 'Здравствуйте';
          title2 = 'Введите пароль';
          installedPinCode = pinCode;
        }
        setState(() {});
      },
    );
  }

  accessUser(
    EnterPintCode type,
    String title2,
    String incomingPin,
    String? installedPin,
  ) {
    if (type == EnterPintCode.create && title1 == 'Придумайте код') {
      if (incomingPin.length == 4) {
        installedPinCode = incomingPin;
        LocalStorage.saveData('user', installedPinCode);
        success.value = true;
        Future.delayed(const Duration(milliseconds: 1800)).then(
          (value) => Navigator.pushReplacement(
            context,
            FadeInRoute(
              const BottomNavigatorPage(),
              '/navigation',
            ),
          ),
        );
      }
    } else if (type == EnterPintCode.enter && incomingPin == installedPin) {
      success.value = true;
      Future.delayed(const Duration(milliseconds: 1800)).then(
        (value) => Navigator.pushReplacement(
          context,
          FadeInRoute(
            const BottomNavigatorPage(),
            '/navigation',
          ),
        ),
      );
    } else {
      success.value = false;
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ValueListenableBuilder(
                  valueListenable: success,
                  builder: (context, _, __) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Text(
                          title1,
                          style: AppTextStyles.s40W300(),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          title2,
                          style: AppTextStyles.s20W400(),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          height: 70,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.grey,
                          ),
                          child: success.value && type == EnterPintCode.create
                              ? const LoadingIndicator()
                              : PinCodeTextField(
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  focusNode: focusNode,
                                  appContext: context,
                                  length: 4,
                                  controller: controller1,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  obscureText: false,
                                  pinTheme: PinTheme(
                                    activeColor: Colors.black,
                                    inactiveColor: Colors.white,
                                    selectedColor: Colors.black,
                                    disabledColor: Colors.red,
                                    shape: PinCodeFieldShape.underline,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 50,
                                    fieldWidth: 40,
                                    activeFillColor: Colors.white,
                                  ),
                                  animationType: AnimationType.fade,
                                  animationDuration:
                                      const Duration(milliseconds: 300),
                                  onChanged: (value) {
                                    accessUser(type, title1, value, null);
                                  },
                                ),
                        ),
                        const Spacer(),
                        if (type != EnterPintCode.create)
                          MainSimpleButton(
                            onTap: () {
                              if (controller1.text != installedPinCode &&
                                  controller1.text.length >= 4) {
                                controller1.clear();
                                Flushbar(
                                  backgroundColor: AppColors.red,
                                  borderRadius: BorderRadius.circular(10),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 16),
                                  flushbarPosition: FlushbarPosition.BOTTOM,
                                  flushbarStyle: FlushbarStyle.FLOATING,
                                  isDismissible: true,
                                  duration: const Duration(seconds: 3),
                                  padding: const EdgeInsets.all(24),
                                  messageText: Text(
                                    'Неправильний пин код',
                                    style: AppTextStyles.s15W400(
                                        color: AppColors.white),
                                  ),
                                  icon: const Icon(
                                    Icons.error_outline,
                                    size: 50,
                                    color: AppColors.white,
                                  ),
                                  mainButton: IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        color: AppColors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                ).show(context);
                              }
                              accessUser(
                                type,
                                title1,
                                controller1.text,
                                installedPinCode,
                              );
                            },
                            isLoading: success.value,
                            title: 'Продолжить',
                          ),
                        const SizedBox(height: 30.0),
                        if (type != EnterPintCode.create)
                          Center(
                            child: InkWell(
                              onTap: () {
                                showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: AppColors.grey,
                                      title: const Text(
                                          'Вы действительно хотите Выйти?'),
                                      actions: <Widget>[
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('Отмена'),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                          child: const Text('Выйти'),
                                          onPressed: () async {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const AuthPage(),
                                              ),
                                              (Route<dynamic> route) => true,
                                            );
                                            await LocalStorage.clearData();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text('Забыли Пароль?'),
                            ),
                          ),
                        const SizedBox(height: 30.0),
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.controller1,
    required this.onChanged,
    this.focusNode,
  });

  final TextEditingController controller1;
  final Function(String)? onChanged;
  FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 40,
      child: TextField(
        focusNode: focusNode,
        onChanged: onChanged,
        controller: controller1,
        // cursorHeight: 30,
        cursorColor: Colors.white,
        // cursorWidth: 2,
        // cursorRadius: const Radius.circular(500),
        style: const TextStyle(
            color: Colors.white, fontSize: 35, height: 1.5 //Add this
            ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(14, 0, 0, 0),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
