import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BooksModel {
  BooksModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });
  final String id;
  final String title;
  final String description;
  final String image;
 

  BooksModel copyWith({
    String? id,
    String? title,
    String? description,
    String? image,
  }) {
    return BooksModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'image': image});
  
    return result;
  }

  factory BooksModel.fromJson(QueryDocumentSnapshot map) {
    return BooksModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  // factory BooksModel.fromJson(String source) => BooksModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BooksModel(id: $id, title: $title, description: $description, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BooksModel &&
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      image.hashCode;
  }
}
