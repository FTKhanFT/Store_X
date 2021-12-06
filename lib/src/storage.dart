import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
import 'package:store_x/src/healpers/print.dart';

@internal
class Storage {
  static final Storage _instance = Storage._internal();

  static Storage get instance => _instance;

  Storage._internal();

  SharedPreferences? prefs;

  bool debugLog = true;

  Future<void> init({
    bool debugLog = true,
  }) async {
    this.debugLog = debugLog;
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (e) {
      Print(
        "Storage could not be initialized: $e",
        type: PrintType.danger,
        debugOnly: this.debugLog,
      );
    }
  }

  Future<bool> store(String value, String key) async {
    if (prefs == null) {
      Print(
        "Storage not initialized",
        type: PrintType.danger,
        debugOnly: debugLog,
      );
      return Future.value(false);
    }
    return await prefs!.setString(key, value);
  }

  String get(String key) {
    if (prefs == null) {
      Print("Storage not initialized",
          type: PrintType.danger, debugOnly: debugLog);
      return '';
    }

    return prefs!.getString(key) ?? '';
  }

  Future<bool> clearKey(String key) async {
    if (prefs == null) {
      Print(
        "Storage not initialized",
        type: PrintType.danger,
        debugOnly: debugLog,
      );
      return Future.value(false);
    }
    return await prefs!.remove(key);
  }

  Future<bool> clearAll() async {
    if (prefs == null) {
      Print(
        "Storage not initialized",
        type: PrintType.danger,
        debugOnly: debugLog,
      );
      return Future.value(false);
    }
    return await prefs!.clear();
  }

  Future<bool> containsKey(String key) async {
    if (prefs == null) {
      Print(
        "Storage not initialized",
        type: PrintType.danger,
        debugOnly: debugLog,
      );
      return Future.value(false);
    }
    return prefs!.containsKey(key);
  }

  List<String> getKeys() {
    if (prefs == null) {
      Print(
        "Storage not initialized",
        type: PrintType.danger,
        debugOnly: debugLog,
      );
      return [] as List<String>;
    }
    return prefs!.getKeys().toList();
  }
}
