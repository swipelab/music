import 'package:app/lob/storage.dart';
import 'package:flutter/foundation.dart';

typedef Marshal<T> = String? Function(T value);
typedef Parser<T> = T? Function(String value);

class ConfigField<T> extends ChangeNotifier {
  ConfigField({
    required this.key,
    required this.marshal,
    required this.parser,
    required this.storage,
    required this.defaultValue,
  });

  static ConfigField<bool> boolean({
    required ValueGetter<String> key,
    required Storage storage,
    bool defaultValue = false,
  }) {
    return ConfigField<bool>(
      key: key,
      marshal: (e) => e ? 'true' : 'false',
      parser: (e) => e == 'true',
      storage: storage,
      defaultValue: () => defaultValue,
    );
  }

  final ValueGetter<String> key;
  final Marshal<T> marshal;
  final Parser<T> parser;
  final Storage storage;
  final ValueGetter<T> defaultValue;

  T? _value;

  T get value {
    final current = _value;
    if (current != null) {
      return current;
    }
    final stored = storage.get(key());
    return stored == null ? defaultValue() : (parser(stored) ?? defaultValue());
  }

  set value(T value) {
    _value = value;
    storage.set(key(), marshal(value));
    notifyListeners();
  }
}
