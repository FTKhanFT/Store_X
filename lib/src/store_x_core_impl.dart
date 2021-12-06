import 'package:store_x/src/encryption.dart';
import 'package:store_x/src/encryption_impl.dart';
import 'package:store_x/src/healpers/print.dart';
import 'package:store_x/src/storage.dart';
import 'package:store_x/src/store_x_core.dart';
import 'package:store_x/src/storable_object.dart';
import 'package:meta/meta.dart';

@internal
class StoreXcoreImpl extends StoreXcore {
  late final Storage _storage;
  late final Encryption _encryption;
  bool _isInitialized = false;

  @override
  bool get isInitialized => _isInitialized;

  @override
  Future<void> init({
    String? encryptionKey,
    bool debugLog = true,
  }) async {
    if (isInitialized) {
      Print(
        "Coulden't initialized StoreX as StoreX is already initialized.",
        debugOnly: debugLog,
        type: PrintType.warning,
      );
    } else {
      _storage = Storage.instance;
      _encryption = EncryptionImpl();

      /// Initialize Storage
      await _storage.init(
        debugLog: true,
      );

      /// Initialize Encryption
      await _encryption.init(
        encryptionKey: encryptionKey,
        debugLog: debugLog,
      );
      _isInitialized = true;
      Print(
        'StoreX initialized',
        type: PrintType.info,
        debugOnly: debugLog,
      );
    }
  }

  @override
  Future<bool> saveAs<T>({
    required T value,
    required String key,
  }) async {
    var storableObject = StorableObject<T>(
      value: value,
      key: key,
    );
    String data = storableObject.toJson();
    String encryptedData = _encryption.encrypt(data);
    return await _storage.store(encryptedData, key);
  }

  @override
  T getAs<T>(String key) {
    String encryptedData = _storage.get(key);
    String decryptedData = _encryption.decrypt(encryptedData);
    StorableObject<T> data = StorableObject.fromJson(decryptedData);
    return data.value;
  }

  @override
  Future<bool> delete(String key) {
    return _storage.clearKey(key);
  }

  @override
  Future<bool> get deleteAll => _storage.clearAll();

  @override
  Future<bool> containsKey(String key) {
    return _storage.containsKey(key);
  }

  @override
  List<String> get getKeys => _storage.getKeys();
}
