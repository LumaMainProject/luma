import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/core/constants/app_icons.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/data/models/enum_gender.dart';
import 'package:luma_2/logic/user/user_bloc.dart';
import 'package:intl/intl.dart';

class BuyerAccountEdit extends StatefulWidget {
  const BuyerAccountEdit({super.key});

  @override
  State<BuyerAccountEdit> createState() => _BuyerAccountEditState();
}

class _BuyerAccountEditState extends State<BuyerAccountEdit> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  DateTime? birthDate;
  String selectedLanguage = "ru";

  @override
  void initState() {
    super.initState();
    final user = context.read<UserBloc>().state;
    if (user is UserLoaded) {
      nameController = TextEditingController(text: user.user.name);
      phoneController = TextEditingController(
        text: user.user.phones.isNotEmpty ? user.user.phones.first : "",
      );
      emailController = TextEditingController(
        text: user.user.emails.isNotEmpty ? user.user.emails.first : "",
      );
      birthDate = user.user.birthDate;
      selectedLanguage = user.user.language;
    } else {
      nameController = TextEditingController();
      phoneController = TextEditingController();
      emailController = TextEditingController();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> pickBirthDate() async {
    final initialDate = birthDate ?? DateTime(2000, 1, 1);
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && mounted) {
      // ✅ проверяем mounted
      setState(() => birthDate = picked);
      context.read<UserBloc>().add(ChangeBirthdayEvent(newBirthDate: picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = state.user;

        return Scaffold(
          appBar: AppBar(title: const Text("Редактировать профиль")),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === Аватар ===
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.paddingMd),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            AppSizes.buttonRadius,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: user.avatarUrl ?? "",
                            width: AppSizes.avatarLg,
                            height: AppSizes.avatarLg,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              width: AppSizes.avatarLg,
                              height: AppSizes.avatarLg,
                              color: Colors.grey.shade200,
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Фото профиля",
                                style: AppTextStyles.cardMainText,
                              ),
                              Text(
                                "Добавьте фотографию для персонализации",
                                style: AppTextStyles.textButton,
                                maxLines: 3,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        OutlinedButton.icon(
                          onPressed: () {},
                          icon: Icon(AppIcons.photoMode),
                          label: const Text("Изменить"),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Text("Имя и фамилия", style: AppTextStyles.headline),
                const SizedBox(height: 6),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: "Пользователь"),
                  onSubmitted: (value) {
                    context.read<UserBloc>().add(
                      ChangeNameEvent(newName: value),
                    );
                  },
                ),

                const SizedBox(height: 20),
                Text("Номер телефона", style: AppTextStyles.headline),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: phoneController,
                        decoration: const InputDecoration(
                          hintText: "Пользователь",
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        context.read<UserBloc>().add(
                          ChangePhoneEvent(newPhone: phoneController.text),
                        );
                      },
                      child: const Text("Изменить номер"),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Text("Email (необязательно)", style: AppTextStyles.headline),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: "Пользователь",
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        context.read<UserBloc>().add(
                          ChangeEmailEvent(newEmail: emailController.text),
                        );
                      },
                      child: const Text("Подтвердить"),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Text("Пол", style: AppTextStyles.headline),
                const SizedBox(height: 6),
                BuyerAccountEditGenderSelector(),

                const SizedBox(height: 20),
                Text(
                  "Дата рождения (необязательно)",
                  style: AppTextStyles.headline,
                ),
                const SizedBox(height: 6),
                GestureDetector(
                  onTap: () => pickBirthDate(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borderColor),
                      borderRadius: BorderRadius.circular(
                        AppSizes.buttonRadius,
                      ),
                    ),
                    child: Text(
                      birthDate != null
                          ? DateFormat('dd.MM.yyyy').format(birthDate!)
                          : "Выберите дату",
                      style: AppTextStyles.text,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                Text("Язык интерфейса", style: AppTextStyles.headline),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.buttonRadius,
                      ),
                      borderSide: BorderSide(color: AppColors.secondary),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.buttonRadius,
                      ),
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.buttonRadius,
                      ),
                      borderSide: BorderSide(
                        color: AppColors.borderColor,
                        width: 2,
                      ),
                    ),
                  ),
                  value: selectedLanguage,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: "ru", child: Text("Русский")),
                    DropdownMenuItem(value: "en", child: Text("English")),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => selectedLanguage = value);
                      context.read<UserBloc>().add(
                        ChangeLanguageEvent(newLanguage: value),
                      );
                    }
                  },
                ),

                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.paddingMd),
                      child: Row(
                        children: [
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Адреса доставки",
                                  style: AppTextStyles.headline,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Управление адресами",
                                  style: AppTextStyles.text,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: null,
                            icon: const Icon(Icons.chevron_right_rounded),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 42),
                const Divider(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BuyerAccountEditGenderSelector extends StatelessWidget {
  const BuyerAccountEditGenderSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) return const SizedBox();

        final genders = [
          {"label": "Не указывать", "value": Gender.unknown},
          {"label": "М", "value": Gender.male},
          {"label": "Ж", "value": Gender.female},
        ];

        return Row(
          children: List.generate(genders.length, (index) {
            final item = genders[index];
            final isActive = state.user.gender == item["value"];

            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: index == 0 ? 0 : 6),
                child: OutlinedButton(
                  onPressed: () {
                    final selectedGender = item["value"] as Gender;
                    context.read<UserBloc>().add(
                      ChangeGenderEvent(newGender: selectedGender),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: isActive
                        ? AppColors.primary.withAlpha(30)
                        : AppColors.white,
                    side: BorderSide(
                      color: isActive
                          ? AppColors.primary
                          : AppColors.borderColor,
                    ),
                  ),
                  child: Text(
                    item["label"] as String,
                    style: AppTextStyles.text.copyWith(
                      color: isActive ? AppColors.primary : AppColors.textDark,
                      fontWeight: isActive
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
