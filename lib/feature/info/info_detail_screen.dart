import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/custom_app_bar.dart';
import 'package:kyz_jubek/core/components/spaces.dart';
import 'package:kyz_jubek/feature/info/info_model.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

import 'package:shimmer/shimmer.dart';

class InfoDetailScreen extends StatelessWidget {
  const InfoDetailScreen({super.key, required this.model});
  final InfoModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: model.title),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 12),
              CachedNetworkImage(
                imageUrl: model.image,
                placeholder: (_, url) {
                  return SizedBox(
                    width: getWidth(context),
                    height: 200,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.withOpacity(0.4),
                      highlightColor: Colors.white,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
                imageBuilder: (_, imageProvider) {
                  return CachedNetworkImage(
                    imageUrl: model.image,
                    width: getWidth(context),
                  );
                },
              ),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    model.description,
                    style: AppTextStyles.s19W600(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
