import 'package:flutter/material.dart';

import 'src/app.dart';


Future<void> main() async {
 

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(const MyApp());
}
