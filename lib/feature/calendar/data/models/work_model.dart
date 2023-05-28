// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
  @HiveField(4)
  final String notes;
  WorkModel({
    required this.date,
    required this.value,
    required this.isComleted,
    required this.id,
    required this.notes,
  });

   

  WorkModel copyWith({
    String? date,
    String? value,
    bool? isComleted,
    int? id,
    String? notes,
  }) {
    return WorkModel(
      date: date ?? this.date,
      value: value ?? this.value,
      isComleted: isComleted ?? this.isComleted,
      id: id ?? this.id,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'date': date});
    result.addAll({'value': value});
    result.addAll({'isComleted': isComleted});
    result.addAll({'id': id});
    result.addAll({'notes': notes});
  
    return result;
  }

  factory WorkModel.fromMap(Map<String, dynamic> map) {
    return WorkModel(
      date: map['date'] ?? '',
      value: map['value'] ?? '',
      isComleted: map['isComleted'] ?? false,
      id: map['id']?.toInt() ?? 0,
      notes: map['notes'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkModel.fromJson(String source) => WorkModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WorkModel(date: $date, value: $value, isComleted: $isComleted, id: $id, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is WorkModel &&
      other.date == date &&
      other.value == value &&
      other.isComleted == isComleted &&
      other.id == id &&
      other.notes == notes;
  }

  @override
  int get hashCode {
    return date.hashCode ^
      value.hashCode ^
      isComleted.hashCode ^
      id.hashCode ^
      notes.hashCode;
  }
}
