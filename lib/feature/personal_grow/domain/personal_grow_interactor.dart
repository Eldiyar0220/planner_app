import 'package:kyz_jubek/feature/personal_grow/data/models/personal_grow_model.dart';
import 'package:kyz_jubek/feature/personal_grow/data/repository/personal_grow_repo.dart';

class PersonalGrowInteractor {
  PersonalGrowInteractor(
    this.repository,
  );
  final GetFromFireBase repository;

  Future<List<PersonalGrowModel>> getBooks() async {
    try {
      return repository.getBooks();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PersonalGrowModel>> getFilms() async {
    try {
      return repository.getFilms();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PersonalGrowModel>> getCountry() async {
    try {
      return repository.getCountry();
    } catch (e) {
      rethrow;
    }
  }
}
