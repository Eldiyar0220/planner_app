import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/custom_app_bar.dart';
import 'package:kyz_jubek/core/components/custom_text_field.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class AreasDetailScreen extends StatefulWidget {
  const AreasDetailScreen({super.key, required this.title});
  final String title;

  @override
  State<AreasDetailScreen> createState() => _AreasDetailScreenState();
}

class _AreasDetailScreenState extends State<AreasDetailScreen> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();
  final controller5 = TextEditingController();

  int qwestion1 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text(
                '1-вопрос:',
                style: AppTextStyles.s16W400(),
              ),
              const SizedBox(height: 5),
              CustomTextField(
                hintText: '',
                controller: controller1,
                onChanged: (value) {
                  setState(() {
                    qwestion1 = int.parse(value);
                  });
                },
                keyboardType: TextInputType.number,
              )
            ],
          ),
        ),
      ),
    );
  }
}
