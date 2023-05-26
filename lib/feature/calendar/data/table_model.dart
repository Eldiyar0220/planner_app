import 'package:hive/hive.dart';

part 'table_model.g.dart';

@HiveType(typeId: 1)
class TableModel extends HiveObject {
  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final String title2;
  @HiveField(2)
  final String title3;

  TableModel({
    required this.date,
    required this.title2,
    required this.title3,
  });

  @override
  String toString() =>
      'TableModel(date: $date, title2: $title2, title3: $title3,  ';
}
