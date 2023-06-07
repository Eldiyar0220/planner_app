import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalGrowModel {
  PersonalGrowModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    this.url = '',
  });
  final String id;
  final String title;
  final String description;
  final String image;
  final String? url;
  

  PersonalGrowModel copyWith({
    String? id,
    String? title,
    String? description,
    String? image,
    String? url,
  }) {
    return PersonalGrowModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'image': image});
    if (url != null) {
      result.addAll({'url': url});
    }

    return result;
  }

  factory PersonalGrowModel.fromJson(QueryDocumentSnapshot map) {
    return PersonalGrowModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      url: map.data().toString().contains('url') ? map['url'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'PersonalGrowModel(id: $id, title: $title, description: $description, image: $image, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PersonalGrowModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.image == image &&
        other.url == url;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        image.hashCode ^
        url.hashCode;
  }
}
