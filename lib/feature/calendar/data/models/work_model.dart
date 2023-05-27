// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'work_model.g.dart';

@HiveType(typeId: 4)
class WorkModel extends HiveObject {
  @HiveField(0)
  final String date;
  @HiveField(1)
  final String value;
  @HiveField(2)
  bool isComleted;
  @HiveField(3)
  final int id;

  WorkModel({
    required this.date,
    required this.value,
    required this.isComleted,
    required this.id,
  });

  @override
  bool operator ==(covariant WorkModel other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.value == value &&
        other.isComleted == isComleted &&
        other.id == id;
  }

  @override
  int get hashCode {
    return date.hashCode ^ value.hashCode ^ isComleted.hashCode ^ id.hashCode;
  }
}
