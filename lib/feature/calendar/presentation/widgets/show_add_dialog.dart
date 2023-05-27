import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/custom_text_field.dart';
import 'package:kyz_jubek/themes/app_colors.dart';

Future<String> showAddDialog(
  BuildContext context,
  String type, {
  TextInputType? keyboardType,
}) async {
  String data = '';

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.grey,
      title: Text('Добавить $type'),
      content: CustomTextField(
        keyboardType: keyboardType,
        hintText: '',
        onChanged: (value) {
          data = value;
        },
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Отмена'),
          onPressed: () {
            data = '';
            Navigator.pop(context);
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Добавить'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
  return data;
}
