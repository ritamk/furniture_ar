import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furniture_ar/controllers/providers.dart';
import 'package:furniture_ar/shared/constants.dart';

import 'package:furniture_ar/views/auth/auth_screen.dart';
import 'package:furniture_ar/views/home/home_screen.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mainTheme(),
      home: ref.watch(authStateChangeStreamProvider).value?.uid != null
          ? const HomeScreen()
          : const AuthScreen(),
    );
  }
}

ThemeData mainTheme() {
  return ThemeData(
    useMaterial3: true,
    fontFamily: "Montserrat",
    dividerColor: const Color.fromARGB(0, 0, 0, 0),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        fontSize: 20.0,
        color: buttonTextCol,
        fontWeight: FontWeight.bold,
        fontFamily: "Montserrat",
      ),
      backgroundColor: buttonCol,
      foregroundColor: buttonTextCol,
    ),
    primarySwatch: Colors.red,
  );
}
