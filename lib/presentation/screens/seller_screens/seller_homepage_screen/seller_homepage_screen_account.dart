import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        },
        child: Text("Выйти из аккаунта"),
      ),
    );
  }
}
