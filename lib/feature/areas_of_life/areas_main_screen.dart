import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/custom_app_bar.dart';
import 'package:kyz_jubek/core/components/spaces.dart';
import 'package:kyz_jubek/core/local_storage/local_storage.dart';
import 'package:kyz_jubek/feature/areas_of_life/areas_itog_screen.dart';
import 'package:kyz_jubek/feature/areas_of_life/areas_list_screen.dart';
import 'package:kyz_jubek/themes/app_colors.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class AreasMainScreen extends StatefulWidget {
  const AreasMainScreen({super.key});

  @override
  State<AreasMainScreen> createState() => _AreasMainScreenState();
}

class _AreasMainScreenState extends State<AreasMainScreen> {
  Future<int> getThemeSumm(int number) async {
    int themeSumm = 0;
    final qw1 = await LocalStorage.readData('list${number}qw1') ?? '';
    final qw2 = await LocalStorage.readData('list${number}qw2') ?? '';
    final qw3 = await LocalStorage.readData('list${number}qw3') ?? '';
    final qw4 = await LocalStorage.readData('list${number}qw4') ?? '';
    final qw5 = await LocalStorage.readData('list${number}qw5') ?? '';
    themeSumm += int.tryParse(qw1) ?? 0;
    themeSumm += int.tryParse(qw2) ?? 0;
    themeSumm += int.tryParse(qw3) ?? 0;
    themeSumm += int.tryParse(qw4) ?? 0;
    themeSumm += int.tryParse(qw5) ?? 0;
    return themeSumm;
  }

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
                      onTap: () async {
                        final theme1 = await getThemeSumm(1);
                        final theme2 = await getThemeSumm(2);
                        final theme3 = await getThemeSumm(3);
                        final theme4 = await getThemeSumm(4);
                        final theme5 = await getThemeSumm(5);
                        final theme6 = await getThemeSumm(6);
                        final theme7 = await getThemeSumm(7);
                        final theme8 = await getThemeSumm(8);
                        final theme9 = await getThemeSumm(9);
                        final theme10 = await getThemeSumm(10);
                        final theme11 = await getThemeSumm(11);
                        final theme12 = await getThemeSumm(12);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AreasItogScreen(
                              theme1: theme1,
                              theme2: theme2,
                              theme3: theme3,
                              theme4: theme4,
                              theme5: theme5,
                              theme6: theme6,
                              theme7: theme7,
                              theme8: theme8,
                              theme9: theme9,
                              theme10: theme10,
                              theme11: theme11,
                              theme12: theme12,
                            ),
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
