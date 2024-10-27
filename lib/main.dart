// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

// Project imports:
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Initialize the map
  await _initializeMap();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}

Future<void> _initializeMap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final String? clientId = dotenv.env['NAVER_MAP_CLIENT_ID'];

  await NaverMapSdk.instance.initialize(
      clientId: clientId,
      onAuthFailed: (e) =>
          log("Naver Map authentication error: $e", name: "onAuthFailed"));
}
