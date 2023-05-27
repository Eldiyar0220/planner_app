import 'dart:convert';

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

  FinanceModel copyWith({
    String? date,
    int? value,
    String? type,
    int? id,
  }) {
    return FinanceModel(
      date: date ?? this.date,
      value: value ?? this.value,
      type: type ?? this.type,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'date': date});
    result.addAll({'value': value});
    result.addAll({'type': type});
    result.addAll({'id': id});

    return result;
  }

  factory FinanceModel.fromMap(Map<String, dynamic> map) {
    return FinanceModel(
      date: map['date'] ?? '',
      value: map['value']?.toInt() ?? 0,
      type: map['type'] ?? '',
      id: map['id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory FinanceModel.fromJson(String source) =>
      FinanceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FinanceModel(date: $date, value: $value, type: $type, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FinanceModel &&
        other.date == date &&
        other.value == value &&
        other.type == type &&
        other.id == id;
  }

  @override
  int get hashCode {
    return date.hashCode ^ value.hashCode ^ type.hashCode ^ id.hashCode;
  }
}
