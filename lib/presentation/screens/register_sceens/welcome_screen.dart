import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:luma_2/core/constants/app_icons.dart';
import 'package:luma_2/core/constants/app_images.dart';
import 'package:luma_2/core/constants/app_strings.dart';
import 'package:luma_2/core/router/app_routes.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/user_role.dart';
import 'package:luma_2/logic/auth/auth_cubit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isBuyer = true;

  final emailController = TextEditingController(text: "tester@example.com");
  final passwordController = TextEditingController();

  bool isEmailNotEmpty = true;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      setState(() {
        isEmailNotEmpty = emailController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleAction(Future<void> Function() action) async {
    if (!mounted) return;

    try {
      await action();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void _navigateToHome() {
    if (!mounted) return;

    final role = context.read<AuthCubit>().role;
    if (role == UserRole.seller) {
      context.go(AppRoute.sellerHomepageScreen.path);
    } else {
      context.go(AppRoute.buyerHomepage.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated || state is GuestAuthenticated) {
          _navigateToHome();
        } else if (state is LinkSent) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Check your email: ${state.email}")),
          );
        }
      },

      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: AppColors.background,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppSpacing.paddingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.logo, width: 120, height: 120),
                const Text(AppStrings.appName, style: AppTextStyles.mainTitle),
                const Text(AppStrings.welcome, style: AppTextStyles.text),

                AppSpacing.verticalLg,

                // --- выбор buyer/seller ---
                SizedBox(
                  height: 120,
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            context.read<AuthCubit>().setRole(UserRole.buyer);
                            setState(() => isBuyer = true);
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
                            context.read<AuthCubit>().setRole(UserRole.seller);
                            setState(() => isBuyer = false);
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

                AppSpacing.verticalLg,

                // --- форма ---
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.paddingMd),
                    child: Column(
                      children: [
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: AppStrings.emailHint,
                          ),
                        ),
                        AppSpacing.verticalMd,
                        TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: AppStrings.passwordHint,
                          ),
                        ),

                        AppSpacing.verticalMd,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Кнопка Google
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.background,
                                    width: 2,
                                  ), // цвет границы
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white, // фон кнопки
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      AppImages.google,
                                      height: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Кнопка Apple
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.background,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      AppImages.apple,
                                      height: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        AppSpacing.verticalMd,

                        ElevatedButton(
                          onPressed: isEmailNotEmpty
                              ? () {
                                  _handleAction(
                                    () => context
                                        .read<AuthCubit>()
                                        .signInWithEmailOnly(
                                          emailController.text,
                                        ),
                                  );
                                }
                              : null, // ✅ если пусто — кнопка не активна
                          child: Text(AppStrings.loginTitle),
                        ),

                        AppSpacing.verticalMd,

                        ElevatedButton(
                          onPressed: () {
                            _handleAction(
                              () => context.read<AuthCubit>().signInAsGuest(),
                            );
                          },
                          child: Text(AppStrings.continueAsGuest),
                        ),

                        AppSpacing.verticalMd,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(AppStrings.forgotPassword),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(AppStrings.forgotPhone),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                AppSpacing.verticalMd,

                TextButton(
                  onPressed: () {
                    context.pushNamed(AppRoute.registrer.name);
                  },
                  child: Text(
                    AppStrings.registerTitle,
                    style: AppTextStyles.buttonDeactive,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
