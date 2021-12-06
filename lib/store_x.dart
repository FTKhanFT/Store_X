library store_x;

import 'package:store_x/src/store_x_core.dart';
import 'package:store_x/src/store_x_core_impl.dart';

export 'package:store_x/src/core_store_store_x_impl.dart'
    show CoreStoreStoreXImpl;

class StoreX {
  static final StoreX _instance = StoreX._internal();
  final StoreXcore _core = StoreXcoreImpl();
  bool get isInitialized => _core.isInitialized;

  ///
  /// `Before Using [StoreX] the [instance] has to be initialized.`
  ///
  /// To initialize [StoreX] use [init] method.
  ///
  /// ```dart
  ///   await StoreX.instance.init(
  ///    encryptionKey: encryptionKey,
  ///    debugLog: true,
  ///   );
  /// ```
  /// {@end-tool}
  ///
  ///
  /// Use [instance] of [StoreX] to save data to storage.
  ///
  /// ```dart
  ///   await StoreX.instance.save<List<String>>(
  ///     value: [
  ///       'false',
  ///       'true',
  ///       'false',
  ///     ],
  ///     key: "test",
  ///   );
  /// ```
  /// {@end-tool}
  ///
  ///
  /// Use [instance] of [StoreX] to get data from storage.
  ///
  /// ```dart
  ///   var value = await StoreX.instance.get<List<String>>(
  ///    key: "test",
  ///   );
  /// ```
  /// {@end-tool}
  ///
  ///
  /// Use [instance] of [StoreX] to delete data from storage.
  ///
  /// ```dart
  ///   await StoreX.instance.delete(
  ///    key: "test",
  ///   );
  /// ```
  /// {@end-tool}
  ///
  ///
  /// Use [instance] of [StoreX] to clear all data from storage.
  ///
  /// ```dart
  ///   await StoreX.instance.deleteAll;
  /// ```
  /// {@end-tool}
  ///
  ///
  /// Use [instance] of [StoreX] to get all keys from storage.
  ///
  /// ```dart
  ///   var keys = await StoreX.instance.keys;
  /// ```
  /// {@end-tool}
  ///
  ///
  /// Use [instance] of [StoreX] to check if [containsKey] in storage.
  ///
  /// ```dart
  ///   var isAvailable = await StoreX.instance.containsKey(
  ///     key: "test",
  ///   );
  /// ```
  /// {@end-tool}
  ///
  ///
  ///
  /// See <https://pub.dev/packages/store_x> for
  /// more discussion on how to use [StoreX].
  ///
  static StoreX get instance {
    return _instance;
  }

  ///
  /// Initializes a new [StoreX] instance by [encryptionKey] and [debugLog].
  ///
  /// Use the [debugLog] option to turn on/off internal debug log of [StoreX]
  ///
  /// ```dart
  /// await StoreX.instance.init(
  ///  encryptionKey: encryptionKey,
  ///  debugLog: true,
  /// );
  /// ```
  /// {@end-tool}
  ///
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
  Future<void> init({
    String? encryptionKey,
    bool debugLog = true,
  }) async {
    /// Initialize the core of StoreX
    await _core.init(
      encryptionKey: encryptionKey,
      debugLog: debugLog,
    );
  }

  ///
  /// Saves [value] to storage with [key].
  /// [key] is a unique identifier for the value.
  /// [value] can be any type of object.
  /// [value] can not be null.
  /// [key] can not be null.
  ///
  /// ``` Type is required to save [value] to storage. ```
  ///
  /// To save A [value] type of [List<String>] to storage use [save] method.
  /// ```dart
  /// await StoreX.instance.save<List<String>>(
  ///  value: [
  ///   'false',
  ///   'true',
  ///   'false',
  ///   ],
  ///  key: "test",
  /// );
  /// ```
  /// {@end-tool}
  ///
  /// To save A [value] type of [double] to storage use [save] method.
  /// ```dart
  /// await StoreX.instance.save<double>(
  ///   value: 1.0,
  ///   key: "test1",
  /// );
  /// ```
  /// {@end-tool}
  ///
  /// See <https://pub.dev/packages/store_x> for
  /// more discussion on how to use [StoreX].
  Future<bool> save<T>({
    required T value,
    required String key,
  }) async {
    assert(isInitialized, 'StoreX is not initialized');
    return await _core.saveAs<T>(value: value, key: key);
  }

  ///
  /// Gets [value] from storage with [key].
  /// [key] is a unique identifier for the value.
  /// [key] can not be null.
  ///
  /// `` Type is required to get [value] from storage. ``
  ///
  /// To get A [value] type of [List<String>] from storage use [get] method.
  /// ```dart
  /// await StoreX.instance.get<List<String>>(
  ///   "test",
  /// );
  /// ```
  /// {@end-tool}
  ///
  /// To get A [value] type of [double] from storage use [get] method.
  /// ```dart
  /// await StoreX.instance.get<double>(
  ///   "test1",
  /// );
  /// ```
  /// {@end-tool}
  ///
  /// See <https://pub.dev/packages/store_x> for
  /// more discussion on how to use [StoreX].
  T get<T>({
    required String key,
  }) {
    assert(isInitialized, 'StoreX is not initialized');
    return _core.getAs<T>(key);
  }

  ///
  /// Deletes [value] from storage with [key].
  /// [key] is a unique identifier for the value.
  /// [key] can not be null.
  ///
  /// To delete A [value] from storage use [delete] method.
  /// ```dart
  /// await StoreX.instance.delete(
  ///  "test",
  /// );
  /// ```
  /// {@end-tool}
  ///
  ///
  /// See <https://pub.dev/packages/store_x> for
  /// more discussion on how to use [StoreX].
  ///
  Future<bool> delete(String key) async {
    assert(isInitialized, 'StoreX is not initialized');
    return _core.delete(key);
  }

  ///
  /// Deletes all values from storage.
  ///
  /// To delete all values from storage use [deleteAll] method.
  /// ```dart
  /// await StoreX.instance.deleteAll;
  /// ```
  /// {@end-tool}
  ///
  /// See <https://pub.dev/packages/store_x> for
  /// more discussion on how to use [StoreX].
  ///
  Future<bool> get deleteAll async {
    assert(isInitialized, 'StoreX is not initialized');
    return _core.deleteAll;
  }

  ///
  /// Checks if [key] exists in storage.
  /// [key] is a unique identifier for the value.
  /// [key] can not be null.
  /// Returns true if [key] exists in storage.
  /// Returns false if [key] does not exist in storage.
  ///
  /// To check if [key] exists in storage use [containsKey] method.
  ///
  /// ```dart
  /// await StoreX.instance.containsKey(
  ///  "test",
  /// );
  /// ```
  /// {@end-tool}
  ///
  ///
  /// See <https://pub.dev/packages/store_x> for
  /// more discussion on how to use [StoreX].
  ///
  Future<bool> containsKey(String key) async {
    assert(isInitialized, 'StoreX is not initialized');
    return _core.containsKey(key);
  }

  ///
  /// Givs the set of keys stored in storage.
  ///
  /// To get the set of keys stored in storage use [keys] method.
  ///
  /// ```dart
  /// Set<String> keys = StoreX.instance.keys;
  /// ```
  /// {@end-tool}
  ///
  ///
  /// See <https://pub.dev/packages/store_x> for
  /// more discussion on how to use [StoreX].
  ///
  List<String> get keys {
    assert(isInitialized, 'StoreX is not initialized');
    return _core.getKeys;
  }

  StoreX._internal();
}
