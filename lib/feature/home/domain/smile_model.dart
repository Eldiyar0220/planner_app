import 'package:hive/hive.dart';

part 'smile_model.g.dart';

@HiveType(typeId: 2)
class SmileModel extends HiveObject {
  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final int item;

  SmileModel({
    required this.date,
    required this.item,
  });

  @override
  String toString() => 'TableModel(date: $date, title2: $item';
}
