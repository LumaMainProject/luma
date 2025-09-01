import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/logic/stores/stores_cubit.dart';

class SellerHomepageScreenContent extends StatelessWidget {
  const SellerHomepageScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoresCubit, StoresState>(
      builder: (context, state) {
        if (state is! StoresLoaded) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(appBar: AppBar(title: Text(state.stores[0].name)));
      },
    );
  }
}
