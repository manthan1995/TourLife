import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_life/constant/preferences_key.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance().then((prefs) {
    preferences = prefs;

    runApp(const MyApp());
  });
}
