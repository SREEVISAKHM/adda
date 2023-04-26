import 'package:adda/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'adda',
      theme: ThemeData(
          timePickerTheme: const TimePickerThemeData(
              helpTextStyle: TextStyle(color: Colors.black, fontSize: 25))),
      home: const Home(),
    );
  }
}
