import 'package:flutter_test/flutter_test.dart';
import 'package:store_x/src/healpers/print.dart';

import 'package:store_x/store_x.dart';

void main() {
  group("StoreX Tests", () {
    test("StoreX should be able to use instance of StoreX", () async {
      StoreX store = StoreX.instance;
      expect(store, isNotNull);
    });
    test('Save and Get String values', () async {
      await StoreX.instance.init();
      await StoreX.instance.save<String>(value: 'test', key: 'test');
      expect(StoreX.instance.get<String>(key: 'test'), 'test');
    });

    test("Save and get double value", () async {
      await StoreX.instance.init();
      await StoreX.instance.save<double>(value: 1.0, key: 'test');
      expect(StoreX.instance.get<double>(key: 'test'), 1.0);
    });
    test("Save and get int value", () async {
      await StoreX.instance.init();
      await StoreX.instance.save<int>(value: 1, key: 'test');
      expect(StoreX.instance.get<int>(key: 'test'), 1);
    });

    test("Save and get bool value", () async {
      await StoreX.instance.init();
      await StoreX.instance.save<bool>(value: true, key: 'test');
      expect(StoreX.instance.get<bool>(key: 'test'), true);
    });

    test("Save and get List<String> value", () async {
      await StoreX.instance.init();
      await StoreX.instance
          .save<List<String>>(value: ['test', 'test2'], key: 'test');
      expect(StoreX.instance.get<List<String>>(key: 'test'), ['test', 'test2']);
    });

    test("Save and get List<int> value", () async {
      await StoreX.instance.init();
      await StoreX.instance.save<List<int>>(value: [1, 2], key: 'test');
      expect(StoreX.instance.get<List<int>>(key: 'test'), [1, 2]);
    });

    test("Save and get List<double> value", () async {
      await StoreX.instance.init();
      await StoreX.instance.save<List<double>>(value: [1.0, 2.0], key: 'test');
      expect(StoreX.instance.get<List<double>>(key: 'test'), [1.0, 2.0]);
    });

    test("Save and get List<bool> value", () async {
      await StoreX.instance.init();
      await StoreX.instance.save<List<bool>>(value: [true, false], key: 'test');
      expect(StoreX.instance.get<List<bool>>(key: 'test'), [true, false]);
    });

    test("Save and get Map<String, dynamic> value", () async {
      await StoreX.instance.init();
      await StoreX.instance
          .save<Map<String, dynamic>>(value: {'test': 'test'}, key: 'test');
      expect(StoreX.instance.get<Map<String, dynamic>>(key: 'test'),
          {'test': 'test'});
    });

    test("Check if containsKey", () async {
      await StoreX.instance.init();
      await StoreX.instance
          .save<Map<String, dynamic>>(value: {'sadf': 'test'}, key: 'test');
      expect(await StoreX.instance.containsKey('test'), true);
    });
    test("Get All Keys.", () async {
      await StoreX.instance.init();
      await StoreX.instance.save<String>(value: 'test', key: 'test');
      await StoreX.instance.save<String>(value: 'test2', key: 'test2');
      Print(StoreX.instance.keys);
      expect(StoreX.instance.keys, ['test', 'test2'].toList());
    });
    test("Delete all keys. result: []", () async {
      await StoreX.instance.init();
      await StoreX.instance.deleteAll;
      expect(StoreX.instance.keys, []);
    });
  });
}
