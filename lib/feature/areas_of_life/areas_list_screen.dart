import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/custom_app_bar.dart';
import 'package:kyz_jubek/core/local_storage/local_storage.dart';
import 'package:kyz_jubek/feature/areas_of_life/areas_detail_screen.dart';
import 'package:kyz_jubek/feature/areas_of_life/widgets/areas_list_widget.dart';

class AreasListScreen extends StatefulWidget {
  const AreasListScreen({super.key});

  @override
  State<AreasListScreen> createState() => _AreasListScreenState();
}

class _AreasListScreenState extends State<AreasListScreen> {
  Future<void> navigateFunc(String title, int number) async {
    final qw1 = await LocalStorage.readData('list${number}qw1') ?? '';
    final qw2 = await LocalStorage.readData('list${number}qw2') ?? '';
    final qw3 = await LocalStorage.readData('list${number}qw3') ?? '';
    final qw4 = await LocalStorage.readData('list${number}qw4') ?? '';
    final qw5 = await LocalStorage.readData('list${number}qw5') ?? '';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AreasDetailScreen(
          title: title,
          qw1: qw1,
          qw2: qw2,
          qw3: qw3,
          qw4: qw4,
          qw5: qw5,
          ref1: 'list${number}qw1',
          ref2: 'list${number}qw2',
          ref3: 'list${number}qw3',
          ref4: 'list${number}qw4',
          ref5: 'list${number}qw5',
        ),
      ),
    );
  }

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
                onTap: () async => await navigateFunc('Отношения', 1),
                title: 'Отношения',
              ),
              AreasListWidget(
                onTap: () async => await navigateFunc('Дружба', 2),
                title: 'Дружба',
              ),
              AreasListWidget(
                onTap: () async => await navigateFunc('Приключения', 3),
                title: 'Приключения',
              ),
              AreasListWidget(
                onTap: () async => await navigateFunc('Здоровье и спорт', 4),
                title: 'Здоровье и спорт',
              ),
              AreasListWidget(
                onTap: () async => await navigateFunc('Обстановка', 5),
                title: 'Обстановка',
              ),
              AreasListWidget(
                onTap: () async =>
                    await navigateFunc('Интеллектуальная жизнь', 6),
                title: 'Интеллектуальная жизнь',
              ),
              AreasListWidget(
                onTap: () async => await navigateFunc('Ваши навыки', 7),
                title: 'Ваши навыки',
              ),
              AreasListWidget(
                onTap: () async => await navigateFunc('Духовная жизнь', 8),
                title: 'Духовная жизнь',
              ),
              AreasListWidget(
                onTap: () async => await navigateFunc('Карьера', 9),
                title: 'Карьера',
              ),
              AreasListWidget(
                onTap: () async => await navigateFunc('Творчество', 10),
                title: 'Творчество',
              ),
              AreasListWidget(
                onTap: () async => await navigateFunc('Семья', 11),
                title: 'Семья',
              ),
              AreasListWidget(
                onTap: () async => await navigateFunc('Общественная жизнь', 12),
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
