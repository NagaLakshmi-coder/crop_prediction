import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String boxName = "local_data";

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  static Box getBox() => Hive.box(boxName);

  // Save data
  static Future<void> saveData(String key, dynamic value) async {
    final box = getBox();
    await box.put(key, value);
  }

  // Get data
  static dynamic getData(String key, {dynamic defaultValue}) {
    final box = getBox();
    return box.get(key, defaultValue: defaultValue);
  }

  // Delete data
  static Future<void> deleteData(String key) async {
    final box = getBox();
    await box.delete(key);
  }
}
