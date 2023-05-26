import 'package:flutter/material.dart';
import 'package:kyz_jubek/feature/calendar/presentation/ui/calendar_page.dart';

class AccountingFinance extends StatelessWidget {
  const AccountingFinance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounting'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: const [
            Text('Доход на __/__/_____'),
            TableBodyWidget(
              children1: [
                'first',
                'first',
              ],
              children2: [
                'first',
                'first',
              ],
              children3: [
                'first',
                'first',
              ],
            )
          ],
        ),
      ),
    );
  }
}
