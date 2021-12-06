import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:store_x/store_x.dart';

///
/// Parse Server's Core Store Implementation of [StoreX]
/// Initialize the [Parse] SDK and provide the [StoreX] as coreStore
///
/// if you are using
/// [parse_server_sdk_flutter](https://pub.dev/packages/parse_server_sdk_flutter)
/// in your project you can use [StoreX](https://pub.dev/packages/store_x) as
/// your core store.
/// When you initialize parse server add [CoreStoreStoreXImpl] instance in there.
///
/// ```dart
/// await Parse().initialize(
///  appId,
///  serverUrl,
///  clientKey: clientKey,
///  liveQueryUrl: serverUrl,
///  coreStore: await CoreStoreStoreXImpl.getInstance(
///    encryptionKey: 'u0TCHVOIiEFVwOqqDo1OnLfd3Kx7yaRt',
///    debugLog: false,
///  ),
///  debug: false,
///  autoSendSessionId: true,
/// );
///```
/// {@end-tool}
///
///
/// After adding the StoreX core store to
/// parse you can use [StoreX] as usual as
/// you have already initialized [StoreX](https://pub.dev/packages/store_x)
///
///
/// See <https://pub.dev/packages/store_x> for
/// more discussion on how to use [StoreX].
///
class CoreStoreStoreXImpl extends CoreStore {
  static CoreStoreStoreXImpl? _instance;
  CoreStoreStoreXImpl._internal();

  static Future<CoreStoreStoreXImpl> getInstance({
    String? encryptionKey,
    bool debugLog = true,
  }) async {
    if (_instance == null) {
      await StoreX.instance.init(
        encryptionKey: encryptionKey,
        debugLog: debugLog,
      );
      _instance = CoreStoreStoreXImpl._internal();
    }
    return _instance!;
  }

  @override
  Future clear() {
    return StoreX.instance.deleteAll;
  }

  @override
  Future<bool> containsKey(String key) {
    return StoreX.instance.containsKey(key);
  }

  @override
  Future get(String key) {
    return StoreX.instance.get<dynamic>(key: key);
  }

  @override
  Future<bool?> getBool(String key) {
    bool? value = StoreX.instance.get<bool>(key: key);
    return Future.value(value);
  }

  @override
  Future<double?> getDouble(String key) {
    double? value = StoreX.instance.get<double>(key: key);
    return Future.value(value);
  }

  @override
  Future<int?> getInt(String key) {
    int? value = StoreX.instance.get<int>(key: key);
    return Future.value(value);
  }

  @override
  Future<String?> getString(String key) {
    String? value = StoreX.instance.get<String>(key: key);
    return Future.value(value);
  }

  @override
  Future<List<String>?> getStringList(String key) {
    List<String>? value = StoreX.instance.get<List<String>>(key: key);
    return Future.value(value);
  }

  @override
  Future remove(String key) {
    return StoreX.instance.delete(key);
  }

  @override
  Future setBool(String key, bool value) {
    return StoreX.instance.save<bool>(key: key, value: value);
  }

  @override
  Future setDouble(String key, double value) {
    return StoreX.instance.save<double>(key: key, value: value);
  }

  @override
  Future setInt(String key, int value) {
    return StoreX.instance.save<int>(key: key, value: value);
  }

  @override
  Future setString(String key, String value) {
    return StoreX.instance.save<String>(key: key, value: value);
  }

  @override
  Future setStringList(String key, List<String> values) {
    return StoreX.instance.save<List<String>>(
      key: key,
      value: values,
    );
  }
}
