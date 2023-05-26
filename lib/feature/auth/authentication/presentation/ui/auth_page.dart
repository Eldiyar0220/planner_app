import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyz_jubek/core/components/loading_indicator.dart';
import 'package:kyz_jubek/core/components/main_simple_button.dart';
import 'package:kyz_jubek/feature/auth/authentication/presentation/auth_cubit/auth_cubit.dart';
import 'package:kyz_jubek/feature/auth/pin_code/presentation/ui/pin_code_page.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  bool isShowQrCode = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer(const Duration(milliseconds: 410), () {
      isShowQrCode = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: screenSize.height,
              child: CachedNetworkImage(
                imageUrl:
                    'https://content-management-files.canva.com/cdn-cgi/image/f=auto,q=70/5c551688-e5f1-47bd-8ec3-fbfc3d900604/header_Plannerss2.jpg',
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error),
                ),
              ),
            ),
            Container(
              height: screenSize.height * 0.6,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 40,
                      left: 15,
                    ),
                    child: Text(
                      "Требуется выполнить вход \n через ${Platform.isAndroid ? 'Google аккаунт' : 'Apple ID'}",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.s18W400(),
                    ),
                  ),
                  const Spacer(),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      state.whenOrNull(
                        singOut: () {},
                        loaded: (user) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PinCodePage(),
                            ),
                          );
                        },
                        loading: () => showDialog(
                          context: context,
                          builder: (context) => const LoadingIndicator(),
                        ),
                      );
                    },
                    builder: (context, state) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: MainSimpleButton(
                        height: 50,
                        onTap: () => context.read<AuthCubit>().getAuth(),
                        title: 'Войти',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
