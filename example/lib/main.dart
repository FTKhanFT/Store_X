import 'package:flutter/material.dart';

import 'package:store_x/store_x.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize password
  // Passowrd length must be 128/192/256 bits
  // you can use the password of 16 character,24 character or 32 character.
  String encryptionKey = 'CBoaDQIQAgceGg8dFAkMDBEOECEZCxg=';

  // Initialize StoreX with encryption key
  await StoreX.instance.init(
    encryptionKey: encryptionKey,
  );

  // Save any type of data to the storage
  await StoreX.instance.save<List<String>>(
    value: [
      'false',
      'true',
      'false',
    ],
    key: "test",
  );

  // Get data from the storage
  List<String>? test = StoreX.instance.get<List<String>>(key: "test");

  print(test);

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}
