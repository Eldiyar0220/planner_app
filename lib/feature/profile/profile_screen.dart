import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/constants/app_text_constants.dart';
import 'package:kyz_jubek/core/local_storage/local_storage.dart';
import 'package:kyz_jubek/feature/profile/edit_profile_screen.dart';
import 'package:kyz_jubek/feature/profile/presentation/ui/widgets/profile_widget.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onTap: () async {},
              ),
              ProfileWidget(
                title: 'Список целей',
                icon: Icons.list,
                onTap: () async {},
              ),
              ProfileWidget(
                title: 'Сайты, карты',
                icon: Icons.map,
                onTap: () async {},
              ),
              ProfileWidget(
                title: 'Подвести итоги',
                icon: Icons.bar_chart_rounded,
                onTap: () async {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
