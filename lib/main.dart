import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grade_flutter/screens/home_screen.dart';
import 'firebase_options.dart';
import 'package:grade_flutter/screens/login_screen.dart';

import 'utils/colors_const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Grade UFBA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: ColorsConst.indigo,
        scaffoldBackgroundColor: ColorsConst.purple[800],
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ColorsConst.indigo,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: ColorsConst.purple,
        ),
        appBarTheme: const AppBarTheme(
          toolbarHeight: 72,
          centerTitle: true,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50),
            ),
          ),
        ),
      ),
      home: const Router(),
    );
  }
}

class Router extends StatelessWidget {
  const Router({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            return HomeScreen(
              user: snapshot.data!,
            );
          } else {
            return const LoginScreen();
          }
        }
      },
    );
  }
}
