import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyz_jubek/core/components/app_error_text.dart';
import 'package:kyz_jubek/core/components/app_indicator.dart';
import 'package:kyz_jubek/core/components/custom_app_bar.dart';
import 'package:kyz_jubek/feature/info/get_info_cubit/get_info_cubit.dart';
import 'package:kyz_jubek/feature/info/widgets/info_widget.dart';
import 'package:kyz_jubek/themes/app_text_styles.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetInfoCubit(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Лента информаций'),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<GetInfoCubit, GetInfoState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => const AppIndicator(),
                      error: (error) => AppErrorText(error: error),
                      success: (model) => model.isEmpty
                          ? Center(
                              child: Text(
                                'Лента пуста',
                                style: AppTextStyles.s16W600(),
                              ),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: ListView.separated(
                                itemCount: model.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) => InfoWidget(
                                  model: model[index],
                                ),
                              ),
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
