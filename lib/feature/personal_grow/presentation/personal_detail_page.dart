import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/custom_app_bar.dart';
import 'package:kyz_jubek/core/components/custom_button.dart';
import 'package:kyz_jubek/core/components/spaces.dart';
import 'package:kyz_jubek/core/components/web_view_screen.dart';
import 'package:kyz_jubek/feature/personal_grow/data/models/personal_grow_model.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class PersonalDetailPage extends StatelessWidget {
  const PersonalDetailPage({
    super.key,
    required this.model,
    required this.title,
  });

  final PersonalGrowModel model;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: model.title),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Column(
          children: [
            Container(
              height: 300,
              width: getWidth(context),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    model.image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  model.description,
                  style: AppTextStyles.s19W700(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomButton(
                text: 'Перейти на сайт',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewScreen(
                        title: model.title,
                        url: model.url!,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
