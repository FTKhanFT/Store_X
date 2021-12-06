import 'package:meta/meta.dart';

@internal
abstract class Encryption {
  Future<void> init({
    String? encryptionKey,
    bool debugLog = true,
  });
  String encrypt(String data);
  String decrypt(String data);
}
