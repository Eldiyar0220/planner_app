import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/custom_app_bar.dart';
import 'package:kyz_jubek/core/components/custom_button.dart';
import 'package:kyz_jubek/feature/personal_grow/data/models/personal_grow_model.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_decoration.dart';
import 'package:shimmer/shimmer.dart';

class PersonalDetailPage extends StatefulWidget {
  const PersonalDetailPage({
    super.key,
    required this.model,
    required this.title,
  });

  final PersonalGrowModel model;
  final String title;

  @override
  State<PersonalDetailPage> createState() => _PersonalDetailPageState();
}

class _PersonalDetailPageState extends State<PersonalDetailPage> {
  int _appRate = 5;
  void _rateStar(int raiting) {
    setState(() {
      _appRate = raiting;
    });
  }

  @override
  Widget build(BuildContext context) {
    final starIcons = List.generate(
      5,
      (index) {
        return Flexible(
          child: Padding(
            padding: const EdgeInsets.only(right: 14),
            child: IconButton(
              onPressed: () => _rateStar(index + 1),
              icon: Icon(
                Icons.star,
                color: _appRate >= index + 1 ? Colors.yellow : Colors.grey,
                size: 40,
              ),
            ),
          ),
        );
      },
    );
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Column(
            children: [
              Container(
                height: 700,
                width: MediaQuery.of(context).size.width,
                decoration: AppDecorations.defaultDeco(
                  color: AppColors.grey,
                ),
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const SizedBox(height: 10.0),
                    Text('O ${widget.title}'),
                    const SizedBox(height: 10.0),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: AppDecorations.defaultDeco(
                          color: Colors.white,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: widget.model.image,
                          placeholder: (_, url) {
                            return SizedBox(
                              height: 100,
                              width: 100,
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
                            return Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    widget.model.image,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [...starIcons],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomButton(
                  text: 'check \$',
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
