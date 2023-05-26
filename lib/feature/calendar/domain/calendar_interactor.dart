import 'package:hive_flutter/hive_flutter.dart';
import 'package:kyz_jubek/feature/calendar/data/table_model.dart';

class CalendarInteractorImpl {
  static Future<List<TableModel>> getDeals(String tableName) async {
    final tableModel = await Hive.openBox<TableModel>(tableName);
    return tableModel.values.toList();
  }

  static Future<void> setDeals({
    required TableModel tableModel,
    required String tableName,
  }) async {
    final boxTable = await Hive.openBox<TableModel>(tableName);
    await boxTable.add(tableModel);
  }
}
