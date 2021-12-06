import 'package:encrypt/encrypt.dart';
import 'package:meta/meta.dart';
import 'package:store_x/src/encryption.dart';
import 'package:store_x/src/healpers/print.dart';

@internal
class EncryptionImpl extends Encryption {
  late Key key;
  final iv = IV.fromLength(16);
  late Encrypter encrypter;
  String password = 'Flutter-Store-X-';
  bool _debugLog = true;

  @override
  String decrypt(String data) {
    try {
      final decrypted = encrypter.decrypt64(data, iv: iv);
      return decrypted;
    } catch (e) {
      Print(
        "Could not decrypt data",
        debugOnly: _debugLog,
        type: PrintType.danger,
      );
      throw Exception();
    }
  }

  @override
  String encrypt(String data) {
    try {
      Encrypted encrypted = encrypter.encrypt(data, iv: iv);

      /// Return encrypted base64 String
      return encrypted.base64;
    } catch (e) {
      Print(
        "Could not encrypt data",
        debugOnly: _debugLog,
        type: PrintType.danger,
      );
      throw Exception();
    }
  }

  @override
  Future<void> init({
    String? encryptionKey,
    bool debugLog = true,
  }) async {
    _debugLog = debugLog;
    if (encryptionKey != null) {
      password = encryptionKey;
    }
    try {
      key = Key.fromUtf8(password);
      encrypter = Encrypter(AES(key));
      Print(
        'StoreX Encryption Initialized',
        debugOnly: _debugLog,
      );
    } catch (e) {
      Print(
        "Could not init encryption",
        debugOnly: _debugLog,
        type: PrintType.danger,
      );
      throw Exception(e);
    }
  }
}
