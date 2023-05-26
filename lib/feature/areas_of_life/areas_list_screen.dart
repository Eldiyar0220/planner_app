import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/custom_app_bar.dart';
import 'package:kyz_jubek/feature/areas_of_life/areas_detail_screen.dart';
import 'package:kyz_jubek/feature/areas_of_life/widgets/areas_list_widget.dart';

class AreasListScreen extends StatelessWidget {
  const AreasListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: '12 сфер жизни'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 12),
              AreasListWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AreasDetailScreen(
                        title: 'Отношения',
                      ),
                    ),
                  );
                },
                title: 'Отношения',
              ),
              AreasListWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AreasDetailScreen(
                        title: 'Дружба',
                      ),
                    ),
                  );
                },
                title: 'Дружба',
              ),
              AreasListWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AreasDetailScreen(
                        title: 'Приключения',
                      ),
                    ),
                  );
                },
                title: 'Приключения',
              ),
              AreasListWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AreasDetailScreen(
                        title: 'Здоровье и спорт',
                      ),
                    ),
                  );
                },
                title: 'Здоровье и спорт',
              ),
              AreasListWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AreasDetailScreen(
                        title: 'Обстановка',
                      ),
                    ),
                  );
                },
                title: 'Обстановка',
              ),
              AreasListWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AreasDetailScreen(
                        title: 'Интеллектуальная жизнь',
                      ),
                    ),
                  );
                },
                title: 'Интеллектуальная жизнь',
              ),
              AreasListWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AreasDetailScreen(
                        title: 'Ваши навыки',
                      ),
                    ),
                  );
                },
                title: 'Ваши навыки',
              ),
              AreasListWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AreasDetailScreen(
                        title: 'Духовная жизнь',
                      ),
                    ),
                  );
                },
                title: 'Духовная жизнь',
              ),
              AreasListWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AreasDetailScreen(
                        title: 'Карьера',
                      ),
                    ),
                  );
                },
                title: 'Карьера',
              ),
              AreasListWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AreasDetailScreen(
                        title: 'Творчество',
                      ),
                    ),
                  );
                },
                title: 'Творчество',
              ),
              AreasListWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AreasDetailScreen(
                        title: 'Семья',
                      ),
                    ),
                  );
                },
                title: 'Семья',
              ),
              AreasListWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AreasDetailScreen(
                        title: 'Общественная жизнь',
                      ),
                    ),
                  );
                },
                title: 'Общественная жизнь',
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
