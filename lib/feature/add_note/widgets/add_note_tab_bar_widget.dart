import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/custom_button.dart';
import 'package:kyz_jubek/core/components/custom_text_field.dart';
import 'package:kyz_jubek/core/components/spaces.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class AddNoteTabBarWidget extends StatelessWidget {
  const AddNoteTabBarWidget({
    super.key,
    required this.title,
    required this.buttonTitle,
    required this.listItems,
  });
  final String title;
  final String buttonTitle;
  final List<String> listItems;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              title,
              style: AppTextStyles.s19W700(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: listItems.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.color0180F5BlueDark,
                  ),
                  child: Text(
                    listItems[index],
                    style: AppTextStyles.s16W400(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            CustomButton(
              text: buttonTitle,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    insetPadding: const EdgeInsets.symmetric(horizontal: 10),
                    content: SizedBox(
                      width: getWidth(context),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 12),
                          Text(
                            'Добавить запись',
                            style: AppTextStyles.s19W600(),
                          ),
                          const SizedBox(height: 12),
                          const CustomTextField(
                            hintText: 'Запись',
                            maxLines: 5,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Отмена'),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Добавить'),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
