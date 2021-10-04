import 'package:adaptive_scaffold/src/myapp.dart';
import 'package:flutter/material.dart';



// Flipping through two demos one with appbar and one with a sliverappbar implementation of
// approaches to adaptive navigation.
Future<void> main() async {
  

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(const MyApp());
}
