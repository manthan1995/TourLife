import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_life/provider/all_provider.dart';
import 'package:tour_life/provider/auth/login_provider.dart';
import 'package:tour_life/provider/forget_provider.dart';
import 'package:tour_life/view/auth/login_screen.dart';
import 'package:tour_life/view/bottom_bar/home_screen.dart';

import 'constant/preferences_key.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider<AllDataProvider>(
          create: (context) => AllDataProvider(),
        ),
        ChangeNotifierProvider<ForgetProvider>(
          create: (context) => ForgetProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: preferences.getString(Keys.tokenValue) == null
            ? const LoginPage()
            : const HomePage(),
      ),
    );
  }
}
