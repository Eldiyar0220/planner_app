import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/spaces.dart';
import 'package:kyz_jubek/feature/home/presentation/widgets/feel_widget.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

Future<int?> showFeelDialog(BuildContext context) async {
  int? grade;
  await showDialog(
    context: context,
    builder: (context) => StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10),
        content: SizedBox(
          width: getWidth(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Text(
                'Какое у вас настроение?',
                style: AppTextStyles.s20W500(),
              ),
              const SizedBox(height: 12),
              Text(
                'Выберите один вариант!',
                style: AppTextStyles.s14W600(),
              ),
              const SizedBox(height: 24),
              FeelWidget(
                isActive: grade == 5,
                grade: 5,
                title: 'Отлично',
                subTitle: 'День был прекрасным!',
                onTap: () {
                  setState(() {
                    grade = 5;
                  });
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 12),
              FeelWidget(
                isActive: grade == 4,
                grade: 4,
                title: 'Хорошо',
                subTitle: 'День был хорошим!',
                onTap: () {
                  setState(() {
                    grade = 4;
                  });
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 12),
              FeelWidget(
                isActive: grade == 3,
                grade: 3,
                title: 'Удовлетворительно',
                subTitle: 'День был не плохим!',
                onTap: () {
                  setState(() {
                    grade = 3;
                  });
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 12),
              FeelWidget(
                isActive: grade == 2,
                grade: 2,
                title: 'Плохо',
                subTitle: 'День был не плохим!',
                onTap: () {
                  setState(() {
                    grade = 2;
                  });
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 12),
              FeelWidget(
                isActive: grade == 1,
                grade: 1,
                title: '------',
                subTitle: '-----------',
                onTap: () {
                  setState(() {
                    grade = 1;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    }),
  );

  return grade;
}
