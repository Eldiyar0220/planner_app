import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/custom_app_bar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Calendare',
        isCanPop: false,
      ),
      body: Center(
        child: Column(
          children: [
            Text('soon create calendar\n под вопрос ??'),
          ],
        ),
      ),
    );
  }
}
