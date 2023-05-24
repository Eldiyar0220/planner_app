import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyz_jubek/core/components/loading_indicator.dart';
import 'package:kyz_jubek/feature/personal_grow/domain/personal_grow_interactor.dart';
import 'package:kyz_jubek/feature/personal_grow/presentation/cubit/personal_grow_cubit.dart';
import 'package:kyz_jubek/feature/personal_grow/presentation/ui/tab_bar_pages/tab_bar_page.dart';

class PersonalGrowPage extends StatelessWidget {
  const PersonalGrowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersonalGrowCubit(
        RepositoryProvider.of<PersonalGrowInteractor>(context),
      )..getFilms(),
      child: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Personal Grow'),
            bottom: const TabBar(
              dividerColor: Colors.transparent,
              tabs: <Widget>[
                Tab(text: 'Книг'),
                Tab(text: 'Фильмы'),
                Tab(text: 'Страны'),
              ],
            ),
          ),
          body: BlocBuilder<PersonalGrowCubit, PersonalGrowState>(
            builder: (context, state) {
              log('state $state');
              return state.when(
                success: (
                  books,
                  films,
                  country,
                ) =>
                    TabBarView(
                  children: <Widget>[
                    TabBarPage(
                      title: 'Книг',
                      model: books,
                    ),
                    TabBarPage(
                      title: 'Фильмы',
                      model: films,
                    ),
                    TabBarPage(
                      title: 'Страны',
                      model: country,
                    ),
                  ],
                ),
                loading: () => const LoadingIndicator(),
                error: () => const Text('error'),
              );
            },
          ),
        ),
      ),
    );
  }
}
