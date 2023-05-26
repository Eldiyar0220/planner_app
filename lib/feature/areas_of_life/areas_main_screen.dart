import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/custom_app_bar.dart';
import 'package:kyz_jubek/core/components/spaces.dart';
import 'package:kyz_jubek/feature/areas_of_life/areas_list_screen.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class AreasMainScreen extends StatelessWidget {
  const AreasMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color38B6FFBLue,
      appBar: const CustomAppBar(title: '12 сфер жизни'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Image.asset('assets/images/logo.png'),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AreasListScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.color0180F5BlueDark,
                        ),
                        width: getHeight(context),
                        child: Text(
                          'Провести анализ',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.s19W700(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.color0180F5BlueDark,
                        ),
                        width: getHeight(context),
                        child: Text(
                          'Изучить итоги',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.s19W700(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
