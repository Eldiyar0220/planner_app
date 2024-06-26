import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyz_jubek/core/components/main_simple_button.dart';
import 'package:kyz_jubek/core/components/spaces.dart';
import 'package:kyz_jubek/core/constants/app_text_constants.dart';
import 'package:kyz_jubek/core/local_storage/local_storage.dart';
import 'package:kyz_jubek/feature/areas_of_life/areas_main_screen.dart';
import 'package:kyz_jubek/feature/auth/authentication/presentation/auth_cubit/auth_cubit.dart';
import 'package:kyz_jubek/feature/auth/authentication/presentation/ui/auth_page.dart';
import 'package:kyz_jubek/feature/profile/edit_profile_screen.dart';
import 'package:kyz_jubek/feature/profile/presentation/ui/widgets/profile_widget.dart';
import 'package:kyz_jubek/feature/reports/report_main_screen.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ValueNotifier valueFinger = ValueNotifier(false);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final result = await LocalStorage.readData('finger');
      if (result != null && result) {
        valueFinger.value = result;
      } else {
        valueFinger.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              FutureBuilder(
                future: LocalStorage.readData(SharedKeys.image),
                builder: (context, image) {
                  if (image.hasData) {
                    return CachedNetworkImage(
                      imageUrl: image.data!,
                      placeholder: (_, url) {
                        return Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.4),
                            highlightColor: Colors.white,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        );
                      },
                      imageBuilder: (_, imageProvider) {
                        return Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                image.data!,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 18),
              FutureBuilder(
                future: LocalStorage.readData(SharedKeys.name),
                builder: (context, name) {
                  if (name.hasData) {
                    return Text(
                      name.data!,
                      style: AppTextStyles.s19W400(),
                    );
                  }
                  return Text(
                    '',
                    style: AppTextStyles.s19W400(),
                  );
                },
              ),
              const SizedBox(height: 5),
              FutureBuilder(
                future: LocalStorage.readData(SharedKeys.authEmail),
                builder: (context, email) {
                  if (email.hasData) {
                    return Text(
                      email.data!,
                      style: AppTextStyles.s19W400(),
                    );
                  }
                  return Text(
                    '',
                    style: AppTextStyles.s19W400(),
                  );
                },
              ),
              const SizedBox(height: 18),
              ProfileWidget(
                title: 'Редактировать профиль',
                icon: Icons.person_2_outlined,
                onTap: () async {
                  final image = await LocalStorage.readData(SharedKeys.image);
                  final name = await LocalStorage.readData(SharedKeys.name);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                        image: image,
                        name: name,
                      ),
                    ),
                  );
                  setState(
                    () {},
                  );
                },
              ),
              ProfileWidget(
                title: '12 сфер жизни',
                icon: Icons.local_florist_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AreasMainScreen(),
                    ),
                  );
                },
              ),
              ProfileWidget(
                title: 'Подвести итоги',
                icon: Icons.bar_chart_rounded,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (contexst) => const ReportMainScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              ValueListenableBuilder(
                  valueListenable: valueFinger,
                  builder: (context, _, __) {
                    return InkWell(
                      splashFactory: NoSplash.splashFactory,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        valueFinger.value = !valueFinger.value;
                        funcSwitcher(valueFinger.value);
                      },
                      child: Container(
                        width: getWidth(context),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: AppColors.color38B6FFBLue,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.fingerprint,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                const SizedBox(width: 10.0),
                                Text(
                                  'Отпечатка пальца',
                                  style: AppTextStyles.s16W400(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                              trackColor: const MaterialStatePropertyAll(
                                Colors.white,
                              ),
                              inactiveThumbColor: Colors.red.shade300,
                              activeColor: Colors.green,
                              value: valueFinger.value,
                              onChanged: (v) async {
                                valueFinger.value = !valueFinger.value;
                                funcSwitcher(valueFinger.value);
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  }),
              ProfileWidget(
                title: 'Выйти',
                icon: Icons.logout,
                color: Colors.red,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Вы действительно хотите выйти?"),
                        content: const Text("Выйти из аккаунта?"),
                        actions: [
                          Row(
                            children: [
                              Expanded(
                                child: MainSimpleButton(
                                  height: 50,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  title: 'Отмена',
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: MainSimpleButton(
                                  color: Colors.red,
                                  height: 50,
                                  onTap: () {
                                    LocalStorage.clearData();
                                    BlocProvider.of<AuthCubit>(context)
                                        .signOut();
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const AuthPage(),
                                      ),
                                      (Route<dynamic> route) => true,
                                    );
                                  },
                                  title: 'Да',
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  funcSwitcher(bool switcher) {
    if (switcher) {
      log('bool ${valueFinger.value}');
      LocalStorage.saveData('finger', switcher);
    } else if (!valueFinger.value) {
      LocalStorage.removeData('finger');
    }
  }
}
