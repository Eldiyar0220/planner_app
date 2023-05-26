import 'dart:convert';

class TableModel {
  final DateTime date;
  final String title2;
  final String title3;
  TableModel({
    required this.date,
    required this.title2,
    required this.title3,
  });

  TableModel copyWith({
    DateTime? date,
    String? title2,
    String? title3,
  }) {
    return TableModel(
      date: date ?? this.date,
      title2: title2 ?? this.title2,
      title3: title3 ?? this.title3,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'date': date.millisecondsSinceEpoch});
    result.addAll({'title2': title2});
    result.addAll({'title3': title3});

    return result;
  }

  factory TableModel.fromMap(Map<String, dynamic> map) {
    return TableModel(
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      title2: map['title2'] ?? '',
      title3: map['title3'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TableModel.fromJson(String source) =>
      TableModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'TableModel(date: $date, title2: $title2, title3: $title3)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TableModel &&
        other.date == date &&
        other.title2 == title2 &&
        other.title3 == title3;
  }

  @override
  int get hashCode => date.hashCode ^ title2.hashCode ^ title3.hashCode;
}
