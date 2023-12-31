import 'package:constraint/state_management.dart';
import 'package:flutter/material.dart';
import 'package:constraint/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Manager(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Inter'),
        home: const HomeScreen());
  }
}
