import 'package:flutter/material.dart';
import 'package:kyz_jubek/feature/add_note/widgets/add_note_tab_bar_widget.dart';
import 'package:kyz_jubek/themes/app_colors.dart';

class AddNoteMainScreen extends StatelessWidget {
  const AddNoteMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.color38B6FFBLue,
          title: const Text('Добавить запись'),
          bottom: const TabBar(
            dividerColor: Colors.transparent,
            tabs: <Widget>[
              Tab(text: 'Благодарность'),
              Tab(text: 'Идеи'),
              Tab(text: 'Победы'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AddNoteTabBarWidget(
              title: 'Список благодарностей',
              buttonTitle: 'Добавить благодарность',
              listItems: [
                'Благодарю тебя за твою доброту',
                'Спасибо за поддержку в трудные времена',
                'Я признателен за твою помощь',
              ],
            ),
            AddNoteTabBarWidget(
              title: 'Список идей',
              buttonTitle: 'Добавить идею',
              listItems: [
                'Создать приложение для обмена книгами',
                'Организовать благотворительный концерт',
                'Запустить онлайн-платформу для обучения программированию',
              ],
            ),
            AddNoteTabBarWidget(
              title: 'Список побед',
              buttonTitle: 'Добавить победу',
              listItems: [
                'Победа в международном шахматном турнире',
                'Завершение проекта в срок и с отличными результатами',
                'Победа команды в финале чемпионата по футболу',
              ],
            ),
          ],
        ),
      ),
    );
  }
}
