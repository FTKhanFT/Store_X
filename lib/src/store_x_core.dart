import 'package:meta/meta.dart';

@internal
abstract class StoreXcore {
  bool isInitialized = false;
  Future<void> init({
    String? encryptionKey,
    bool debugLog = true,
  });
  T getAs<T>(String key);
  Future<bool> saveAs<T>({
    required T value,
    required String key,
  });
  Future<bool> containsKey(String key);
  Future<bool> delete(String key);
  Future<bool> get deleteAll;
  List<String> get getKeys;
}
