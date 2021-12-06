import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:store_x/src/healpers/print.dart';

@internal
class StorableObject<T> {
  final T value;
  final String key;

  StorableObject({
    required this.value,
    required this.key,
  });
  Type get type => T;

  @override
  String toString() =>
      'StorableObject(key: $key, value: $value, type: ${type.toString()})';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StorableObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'value': value,
      'type': T.toString(),
    };
  }

  factory StorableObject.fromMap(Map<String, dynamic> map) {
    if (map['type'] != T.toString()) {
      Print(
        "Type mismatch. Expected ${T.toString()} but got ${map['type']}",
        type: PrintType.danger,
      );
      throw Exception("Type mismatch");
    }
    dynamic value = map['value'];

    if (value is List<dynamic> && T is! List<dynamic> && value.isNotEmpty) {
      switch (value[0].runtimeType.toString()) {
        case 'String':
          value = value.cast<String>();
          break;
        case 'double':
          value = value.cast<double>();
          break;
        case 'int':
          value = value.cast<int>();
          break;
        case 'bool':
          value = value.cast<bool>();
          break;
      }
    }
    return StorableObject<T>(
      key: map['key'],
      value: value,
    );
  }
  String toJson() => json.encode(toMap());

  factory StorableObject.fromJson(String source) =>
      StorableObject.fromMap(json.decode(source));
}
