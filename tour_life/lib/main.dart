import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_life/constant/preferences_key.dart';
import 'package:tour_life/widget/ExpandedListAnimationWidget.dart';
import 'package:tour_life/widget/scrollbar.dart';

import 'app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance().then((prefs) {
    preferences = prefs;
    runApp(const MyApp());
  });
}
