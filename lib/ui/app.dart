import 'package:flutter/material.dart';
import 'package:luma/global/app_colors.dart';
import 'package:luma/ui/pages/page_register.dart';

class Luma extends StatelessWidget {
  const Luma({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luma',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor),
      ),
      home: const PageRegister(),
    );
  }
}
