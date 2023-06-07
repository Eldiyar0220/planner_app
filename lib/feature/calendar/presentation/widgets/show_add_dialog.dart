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

class SomeModel {
  String mainText;
  String notes;
  SomeModel({
    required this.mainText,
    this.notes = '',
  });
}

Future<SomeModel> showAddDialogWithNotes(
  BuildContext context,
  String type, {
  TextInputType? keyboardType,
}) async {
  String mainText = '';
  String notes = '';

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.grey,
      title: Text('Добавить $type'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            keyboardType: keyboardType,
            hintText: type,
            onChanged: (value) {
              mainText = value;
            },
          ),
          const SizedBox(height: 10.0),
          CustomTextField(
            hintText: 'Заметки',
            onChanged: (value) {
              notes = value;
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Отмена'),
          onPressed: () {
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
  return SomeModel(mainText: mainText, notes: notes);
}
