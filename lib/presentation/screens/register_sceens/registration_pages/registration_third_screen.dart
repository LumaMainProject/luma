import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/logic/registration/registration_bloc.dart';

class RegistrationThirdScreen extends StatefulWidget {
  const RegistrationThirdScreen({super.key});

  @override
  State<RegistrationThirdScreen> createState() =>
      _RegistrationThirdScreenState();
}

class _RegistrationThirdScreenState extends State<RegistrationThirdScreen> {
  bool isUserAgreed = false;
  bool isEmailAgreed = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsetsGeometry.all(AppSpacing.paddingMd),
      child: Card(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(AppSpacing.paddingMd),
          child: Column(
            children: [
              Text("Согласие с условиями", style: AppTextStyles.headline),
              AppSpacing.verticalMd,
              Row(
                children: [
                  Checkbox(
                    value: isUserAgreed,
                    onChanged: (value) {
                      isUserAgreed = value ?? false;
                      context.read<RegistrationBloc>().add(
                        SetAgreements(
                          agreedToTerms: isUserAgreed,
                          agreedToEmails: isEmailAgreed,
                        ),
                      );
                      setState(() {});
                    },
                  ),
                  Expanded(
                    child: Text(
                      "Согласен с Условиями использования и Политикой конфиденциальности",
                      style: AppTextStyles.text,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
              AppSpacing.verticalMd,
              Row(
                children: [
                  Checkbox(
                    value: isEmailAgreed,
                    onChanged: (value) {
                      isEmailAgreed = value ?? false;
                      context.read<RegistrationBloc>().add(
                        SetAgreements(
                          agreedToTerms: isUserAgreed,
                          agreedToEmails: isEmailAgreed,
                        ),
                      );
                      setState(() {});
                    },
                  ),
                  Expanded(
                    child: Text(
                      "Получать промо-рассылки и уведомления о скидках",
                      style: AppTextStyles.text,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
              AppSpacing.verticalMd,
              ElevatedButton(
                onPressed: () {
                  context.read<RegistrationBloc>().add(SubmitRegistration());
                },
                child: Text("Создать аккаунт"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
