import 'package:flutter/material.dart';
import 'package:luma/domain/buyer_bloc/buyer_account_bloc.dart';
import 'package:luma/domain/manager_bloc/manager_bloc.dart';
import 'package:luma/domain/seller_bloc/seller_account_bloc.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/saves/saves.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<BuyerAccountBloc>(
          create: (context) =>
              BuyerAccountBloc()..add(const BuyerAccountLoadEvent()),
        ),

        BlocProvider<ManagerBloc>(
          create: (context) =>
              ManagerBloc()..add(ManagerLoadEvent(currentPage: 1)),
        ),

        BlocProvider<SellerAccountBloc>(
          create: (context) =>
              SellerAccountBloc()
                ..add(SellerAccountLoadEvent(shop: SaveShop.adidas)),
        ),
      ],

      child: MaterialApp(
        title: 'Luma',
        debugShowCheckedModeBanner: false,
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
