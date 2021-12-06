import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:flutter/widgets.dart';
import 'package:helpers/helpers/print.dart';

@internal
enum PrintType {
  warning,
  danger,
  info,
}

@internal
extension PrintTypeExtension on PrintType {
  Color get color {
    switch (this) {
      case PrintType.warning:
        return const Color(0xAAFFBB00);
      case PrintType.danger:
        return const Color(0xAAFF0000);
      case PrintType.info:
        return const Color(0xAA0077FF);
    }
  }

  String get name {
    switch (this) {
      case PrintType.warning:
        return 'Warning';
      case PrintType.danger:
        return 'Danger';
      case PrintType.info:
        return 'Info';
    }
  }
}

@internal
class Print {
  Print(
    Object? object, {
    PrintType type = PrintType.info,
    bool debugOnly = true,
  }) {
    if (!debugOnly && !kDebugMode) return;
    printColor(
      object,
      PrintColorStyle(
        bold: true,
        prefix: 'StoreX',
        foreground: type.color,
        italic: false,
        underline: false,
      ),
    );
  }
}
