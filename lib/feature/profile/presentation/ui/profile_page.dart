import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kyz_jubek/core/components/main_simple_button.dart';
import 'package:kyz_jubek/core/constants/app_text_constants.dart';
import 'package:kyz_jubek/core/local_storage/local_storage.dart';
import 'package:kyz_jubek/feature/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:kyz_jubek/feature/auth/presentation/ui/auth_page.dart';
import 'package:kyz_jubek/feature/profile/presentation/ui/widgets/test_page.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_decoration.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ValueNotifier userEmail = ValueNotifier<String>('');
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
      userEmail.value = isLogged;
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthPage(),
        ),
      );
    }
  }

  List<ModelProfile> underScreens = [
    ModelProfile(title: '12 сфер жизни', page: const TestPage()),
    ModelProfile(title: 'Список целей', page: const TestPage()),
    ModelProfile(title: 'Сайты, карты', page: const TestPage()),
    ModelProfile(title: 'Подвести итоги', page: const TestPage()),
  ];

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мой профиль'),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 5),
        child: Column(
          children: [
            Container(
              decoration: AppDecorations.defaultDeco(
                color: AppColors.black.withOpacity(0.3),
              ),
              padding: const EdgeInsets.all(10),
              height: mQ * 0.3,
              width: mQ,
              child: Column(
                children: [
                  ValueListenableBuilder(
                      valueListenable: userEmail,
                      builder: (context, _, __) {
                        return SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://content-management-files.canva.com/cdn-cgi/image/f=auto,q=70/5c551688-e5f1-47bd-8ec3-fbfc3d900604/header_Plannerss2.jpg',
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
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
                                  errorWidget: (context, url, error) =>
                                      const Center(
                                    child: Icon(Icons.error),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Text(userEmail.value),
                            ],
                          ),
                        );
                      }),
                  const Spacer(),
                  MainSimpleButton(
                    height: 30,
                    onTap: () {},
                    title: 'Редактировать',
                  )
                ],
              ),
            ),
            const SizedBox(height: 60.0),
            ...underScreens.map(
              (model) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: MainSimpleButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => model.page),
                    );
                  },
                  title: model.title,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ModelProfile {
  final String title;
  final Widget page;
  ModelProfile({
    required this.title,
    required this.page,
  });
}
