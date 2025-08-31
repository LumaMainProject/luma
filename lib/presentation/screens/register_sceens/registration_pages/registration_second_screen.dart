import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/logic/registration/registration_bloc.dart';

class RegistrationSecondScreen extends StatelessWidget {
  const RegistrationSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      // 🔹 Контент будет по центру PageView
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.paddingMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // центр по вертикали
          crossAxisAlignment: CrossAxisAlignment.center, // центр по горизонтали
          children: [
            Text("Подтверждение номера", style: AppTextStyles.headline),
            AppSpacing.verticalMd,
            Text("Мы отправили код на ваш Email", style: AppTextStyles.text),
            AppSpacing.verticalMd,
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.paddingMd),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(),
                    AppSpacing.verticalMd,
                    ElevatedButton(
                      onPressed: () {
                        context.read<RegistrationBloc>().add(VerifyEmail());
                      },
                      child: const Text("Подтвердить"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
