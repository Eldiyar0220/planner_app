import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/custom_app_bar.dart';
import 'package:kyz_jubek/core/components/custom_button.dart';
import 'package:kyz_jubek/core/components/spaces.dart';
import 'package:kyz_jubek/core/components/web_view_screen.dart';
import 'package:kyz_jubek/feature/personal_grow/data/models/personal_grow_model.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _rateStar(int raiting) {
    setState(() {
      _appRate = raiting;
    });
  }

  @override
  Widget build(BuildContext context) {
    final starIcons = List.generate(5, (index) {
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
    });
    return Scaffold(
      appBar: CustomAppBar(title: widget.model.title),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.withOpacity(0.9),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      width: getWidth(context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            widget.model.image,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [...starIcons],
                    ),
                    const SizedBox(height: 10.0),
                  ],
                )),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.model.description,
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
                        title: widget.model.title,
                        url: widget.model.url!,
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
