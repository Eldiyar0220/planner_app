import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyz_jubek/core/components/custom_route_anim.dart';
import 'package:kyz_jubek/feature/personal_grow/data/models/personal_grow_model.dart';
import 'package:kyz_jubek/feature/personal_grow/presentation/cubit/personal_grow_cubit.dart';
import 'package:kyz_jubek/feature/personal_grow/presentation/personal_detail_page.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_decoration.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class TabBarPage extends StatelessWidget {
  const TabBarPage({
    super.key,
    required this.model,
    required this.title,
  });

  final List<PersonalGrowModel> model;
  final String title;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<PersonalGrowCubit>().getFilms();
      },
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: model.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 10),
        itemBuilder: (BuildContext context, int index) {
          final item = model[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                StandardUniversalAnimations(
                  child: PersonalDetailPage(
                    title: title,
                    model: item,
                  ),
                  milliSecondsToShow: 300,
                  milliSecondsToClose: 300,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.only(right: 5),
              height: 80,
              width: 140,
              decoration:
                  AppDecorations.defaultDeco(color: AppColors.color38B6FFBLue),
              child: Row(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    width: 70,
                    decoration: AppDecorations.defaultDeco(),
                    child: CachedNetworkImage(
                      imageUrl: item.image,
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: AppTextStyles.s15W700(
                              color: AppColors.black,
                            ),
                          ),
                          Text(
                            item.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.s14W500(
                              color: AppColors.black.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
