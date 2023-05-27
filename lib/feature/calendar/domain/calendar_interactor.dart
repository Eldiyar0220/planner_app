import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyz_jubek/feature/calendar/data/models/work_model.dart';
import 'package:kyz_jubek/feature/calendar/data/table_model.dart';

class CalendarInteractorImpl {
  static Future<List<TableModel>> getDeals(String tableName) async {
    final tableModel = await Hive.openBox<TableModel>(tableName);
    return tableModel.values.toList();
  }

  static Future<List<WorkModel>> getDeals2(String tableName) async {
    final tableModel = Hive.isBoxOpen(tableName)
        ? Hive.box<WorkModel>(tableName)
        : await Hive.openBox<WorkModel>(tableName);

    return tableModel.values.toList();
  }

  static Future<void> setDeals({
    required TableModel tableModel,
    required String tableName,
  }) async {
    final boxTable = await Hive.openBox<TableModel>(tableName);
    await boxTable.add(tableModel);
  }

  static Future<void> deleteLoveDiary({
    required String tableName,
    required String title,
  }) async {
    final bmiBox = await Hive.openBox<TableModel>(tableName);
    final loveModel =
        bmiBox.values.toList().singleWhere((e) => e.title2 == title);
    await loveModel.delete();
    await bmiBox.compact();
  }
}
