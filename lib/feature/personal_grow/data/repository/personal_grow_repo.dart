import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kyz_jubek/feature/personal_grow/data/models/personal_grow_model.dart';

abstract class GetFromFireBase {
  Future<List<PersonalGrowModel>> getBooks();
  Future<List<PersonalGrowModel>> getFilms();
  Future<List<PersonalGrowModel>> getCountry();
}

class GetFromFireBaseImpl implements GetFromFireBase {
  Future<QuerySnapshot<Object?>> getData(String ref) async {
    return FirebaseFirestore.instance.collection(ref).get();
  }

  @override
  Future<List<PersonalGrowModel>> getFilms() async {
    final films = await getData('films');

    return films.docs
        .map<PersonalGrowModel>((e) => PersonalGrowModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<PersonalGrowModel>> getBooks() async {
    final books = await getData('info');

    return books.docs
        .map<PersonalGrowModel>((e) => PersonalGrowModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<PersonalGrowModel>> getCountry() async {
    final country = await getData('countries');

    return country.docs
        .map<PersonalGrowModel>((e) => PersonalGrowModel.fromJson(e))
        .toList();
  }
}
