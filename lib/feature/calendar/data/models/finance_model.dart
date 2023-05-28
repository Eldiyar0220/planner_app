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
  @HiveField(4)
  final String notes;

  FinanceModel({
    required this.date,
    required this.value,
    required this.type,
    required this.id,
    required this.notes,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FinanceModel &&
        other.date == date &&
        other.value == value &&
        other.type == type &&
        other.id == id &&
        other.notes == notes;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        value.hashCode ^
        type.hashCode ^
        id.hashCode ^
        notes.hashCode;
  }
}
