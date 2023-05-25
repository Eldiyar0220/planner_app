import 'package:flutter/material.dart';
import 'package:kyz_jubek/core/components/custom_app_bar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Calendare',
        isCanPop: false,
      ),
      body: Center(
        child: Column(
          children: const [
            Text('soon create calendar\n под вопрос ??'),
          ],
        ),
      ),
    );
  }
}
