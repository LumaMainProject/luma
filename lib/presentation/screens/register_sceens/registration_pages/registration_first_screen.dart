import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/core/constants/app_icons.dart';
import 'package:luma_2/core/constants/app_strings.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/logic/registration/registration_bloc.dart';

class RegistrationFirstScreen extends StatefulWidget {
  const RegistrationFirstScreen({super.key});

  @override
  State<RegistrationFirstScreen> createState() =>
      _RegistrationFirstScreenState();
}

class _RegistrationFirstScreenState extends State<RegistrationFirstScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isBuyer = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.paddingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Выберите роль", style: AppTextStyles.headline),

          AppSpacing.verticalMd,
          // --- выбор buyer/seller ---
          SizedBox(
            height: 120,
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      isBuyer = true;
                      setState(() {});
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(double.infinity),
                      backgroundColor: isBuyer
                          ? AppColors.primary.withAlpha(25)
                          : AppColors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(AppIcons.buyer, size: AppSizes.avatarSm),
                        AppSpacing.verticalSm,
                        Text(AppStrings.buyer),
                      ],
                    ),
                  ),
                ),
                AppSpacing.horizontalMd,
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      isBuyer = false;
                      setState(() {});
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(double.infinity),
                      backgroundColor: !isBuyer
                          ? AppColors.primary.withAlpha(25)
                          : AppColors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(AppIcons.seller, size: AppSizes.avatarSm),
                        AppSpacing.verticalSm,
                        Text(AppStrings.seller),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          AppSpacing.verticalMd,

          Text("Введите имя", style: AppTextStyles.headline),
          AppSpacing.verticalSm,
          TextField(controller: nameController),

          AppSpacing.verticalMd,

          Card(
            child: Padding(
              padding: const EdgeInsetsGeometry.all(AppSpacing.paddingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email", style: AppTextStyles.cardMainText),
                  AppSpacing.verticalMd,
                  TextField(controller: emailController),
                  AppSpacing.verticalMd,
                  ElevatedButton(
                    onPressed: () {
                      context.read<RegistrationBloc>().add(
                        SetName(nameController.text.trim()),
                      );
                      context.read<RegistrationBloc>().add(
                        SetEmail(emailController.text.trim()),
                      );
                    },
                    child: Text("Получить код"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
