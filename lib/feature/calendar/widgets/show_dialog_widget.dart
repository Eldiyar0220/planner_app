import 'package:flutter/material.dart';
import 'package:kyz_jubek/themes/app_colors.dart';

class ShowDialogWidget {
  static Future<String> dialogBuilder(
    BuildContext context, {
    required String title,
  }) {
    TextEditingController controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.grey,
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: AppColors.white,
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Отмена'),
              onPressed: () => Navigator.of(context).pop(''),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Добавить'),
              onPressed: () => Navigator.of(context).pop(controller.text),
            ),
          ],
        );
      },
    ).then((value) => value ?? '');
  }
}
