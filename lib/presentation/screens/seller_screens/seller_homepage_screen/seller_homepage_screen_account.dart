import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luma_2/core/router/app_routes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/logic/auth/auth_cubit.dart';

class SellerHomepageScreenAccount extends StatelessWidget {
  const SellerHomepageScreenAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSpacing.paddingMd),
      child: FilledButton(
        onPressed: () {
          context.read<AuthCubit>().signOut();
          context.go(AppRoute.auth.name);
        },
        child: Text("Выйти из аккаунта"),
      ),
    );
  }
}
