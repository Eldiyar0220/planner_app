import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyz_jubek/core/components/loading_indicator.dart';
import 'package:kyz_jubek/feature/personal_grow/domain/personal_grow_interactor.dart';
import 'package:kyz_jubek/feature/personal_grow/presentation/cubit/personal_grow_cubit.dart';
import 'package:kyz_jubek/feature/personal_grow/presentation/ui/tab_bar_pages/tab_bar_page.dart';
import 'package:kyz_jubek/themes/app_colors.dart';

class PersonalGrowPage extends StatelessWidget {
  const PersonalGrowPage({super.key});
 

  @override
  Widget build(BuildContext context) {
    const String booksTitle = 'Книги';
    const String filmsTitle = 'Фильмы';
    const String countryTitle = 'Страны';
    return BlocProvider(
      create: (context) => PersonalGrowCubit(
        RepositoryProvider.of<PersonalGrowInteractor>(context),
      )..getFilms(),
      child: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: const SizedBox.shrink(),
            backgroundColor: AppColors.color38B6FFBLue,
            title: const Text('Personal Grow'),
            bottom: const TabBar(
              dividerColor: Colors.transparent,
              tabs: <Widget>[
                Tab(text: booksTitle),
                Tab(text: filmsTitle),
                Tab(text: countryTitle),
              ],
            ),
          ),
          body: BlocBuilder<PersonalGrowCubit, PersonalGrowState>(
            builder: (context, state) {
              return state.when(
                success: (
                  books,
                  films,
                  country,
                ) =>
                    TabBarView(
                  children: <Widget>[
                    TabBarPage(
                      title: booksTitle,
                      model: books,
                    ),
                    TabBarPage(
                      title: filmsTitle,
                      model: films,
                    ),
                    TabBarPage(
                      title: countryTitle,
                      model: country,
                    ),
                  ],
                ),
                loading: () => const LoadingIndicator(),
                error: () => const Center(child: Text('Сетевая ошибка')),
              );
            },
          ),
        ),
      ),
    );
  }
}
