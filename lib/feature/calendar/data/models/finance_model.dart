import 'package:hive/hive.dart';

part 'finance_model.g.dart';

@HiveType(typeId: 3)
class FinanceModel extends HiveObject {
  @HiveField(0)
  final String date;
  @HiveField(1)
  final int value;
  @HiveField(2)
  final String type;
  @HiveField(3)
  final int id;

  FinanceModel({
    required this.date,
    required this.value,
    required this.type,
    required this.id,
  });

  @override
  String toString() {
    return 'FinanceModel(date: $date, value: $value, type: $type, id: $id)';
  }
}
