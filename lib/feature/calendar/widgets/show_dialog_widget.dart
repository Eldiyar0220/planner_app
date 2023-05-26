import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kyz_jubek/themes/app_colors.dart';

class ShowDialogWidget {
  static Future<String> dialogBuilder(
    BuildContext context, {
    required String title,
  }) {
    TextEditingController controller = TextEditingController();
    FocusNode accFocusNode = FocusNode();
    Timer(
      const Duration(milliseconds: 40),
      () => accFocusNode.requestFocus(),
    );
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.grey,
          title: Text(title),
          content: TextField(
            focusNode: accFocusNode,
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

  static Future<bool> confirmDelete(BuildContext context,
      {required String title}) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.grey,
          title: const Text('Вы действительно хотите удалить?'),
          content: Text(title),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Отмена'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Удалть'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }
}
