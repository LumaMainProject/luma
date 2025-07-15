import 'package:flutter/material.dart';
import 'package:luma/domain/bloc/buyer_account_bloc.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/ui/pages/page_register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Luma extends StatefulWidget {
  const Luma({super.key});

  @override
  State<Luma> createState() => _LumaState();
}

class _LumaState extends State<Luma> {
  ThemeMode themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BuyerAccountBloc()..add(const BuyerAccountLoadEvent()),
      child: MaterialApp(
        title: 'Luma',
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          colorSchemeSeed: AppColors.mainColor,
          fontFamily: 'ARIAL',
        ),
        home: const PageRegister(),
      ),
    );
  }
}
