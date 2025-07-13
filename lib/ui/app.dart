import 'package:flutter/material.dart';
import 'package:luma/ui/pages/page_register.dart';

class Luma extends StatefulWidget {
  const Luma({super.key});

  @override
  State<Luma> createState() => _LumaState();
}

class _LumaState extends State<Luma> {
  ThemeMode themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luma',
      theme: ThemeData(useMaterial3: true, brightness: Brightness.light),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      themeMode: themeMode,
      home: const PageRegister(),
    );
  }
}
