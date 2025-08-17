import 'package:flutter/material.dart';
import 'package:luma/global/params/app_button_style.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_icons.dart';
import 'package:luma/global/params/app_router.dart';
import 'package:luma/global/params/app_settings.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/widgets/custom_text_field.dart';

class PageRegister extends StatefulWidget {
  const PageRegister({super.key});

  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  bool isCurrentlyActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(backgroundColor: AppColors.backgroundColor, elevation: 0),
      ),

      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 28,
                  child: Text("LUMA", style: AppTextStyles.logo),
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: 21,
                  child: Text(
                    "Добро пожаловать в LUMA",
                    style: AppTextStyles.description,
                  ),
                ),

                const SizedBox(height: 28),

                Row(
                  children: [
                    PageRegisterCustomButton(
                      isActive: isCurrentlyActive,
                      text: "Покупатель",
                      icon: AppIcons.registerAccount,
                      function: () {
                        isCurrentlyActive = true;
                        setState(() {});
                      },
                    ),
                    const SizedBox(width: 14),
                    PageRegisterCustomButton(
                      isActive: !isCurrentlyActive,
                      text: "Продавец",
                      icon: AppIcons.registerShop,
                      function: () {
                        isCurrentlyActive = false;
                        setState(() {});
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                PageRegisterFields(),

                const SizedBox(height: 30),

                TextButton(
                  style: AppButtonStyle.textMinorButton,
                  onPressed: () {},
                  child: Text(
                    "+ Создать аккаунт",
                    style: AppTextStyles.textButtonOutcast,
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

class PageRegisterCustomButton extends StatelessWidget {
  final bool isActive;
  final String text;
  final IconData icon;
  final Function() function;
  const PageRegisterCustomButton({
    super.key,
    this.isActive = false,
    this.text = "TEST",
    this.icon = Icons.abc,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        style: isActive
            ? AppButtonStyle.activeRegisterPageButton
            : AppButtonStyle.deactiveRegisterPageButton,
        onPressed: function,
        child: Column(
          children: [
            const SizedBox(height: 22),
            ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Container(
                color: isActive ? AppColors.mainColor : AppColors.secondColor,
                padding: const EdgeInsets.all(10),
                child: Icon(
                  icon,
                  size: 20,
                  color: isActive ? AppColors.whiteColor : AppColors.mainColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(text, style: AppTextStyles.title),
            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }
}

class PageRegisterFields extends StatelessWidget {
  const PageRegisterFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        border: BoxBorder.all(width: 1, color: AppColors.inactiveBorderColor),
        borderRadius: BorderRadius.all(
          Radius.circular(AppSettings.borderAngle),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12, // shadow color
            spreadRadius: 1, // how much it spreads
            blurRadius: 8, // softening
            offset: Offset(0, 4), // x,y position of shadow
          ),
        ],
      ),

      child: Column(
        children: [
          CustomTextField(
            hintText: "+998 __ ___ __ __  или  name@mail.com",
            function: () {},
          ),

          const SizedBox(height: 14),

          CustomTextField(
            isSuffixActive: true,
            hintText: "••••••",
            function: () {},
          ),

          const SizedBox(height: 22),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.outlined(
                onPressed: () {},
                style: AppButtonStyle.iconButton,
                icon: Icon(
                  AppIcons.google,
                  size: 21,
                  color: AppColors.mainColor,
                ),
              ),

              IconButton.outlined(
                onPressed: () {},
                style: AppButtonStyle.iconButton,
                icon: Icon(AppIcons.ios, size: 21, color: AppColors.mainColor),
              ),
            ],
          ),

          const SizedBox(height: 36),

          SizedBox(
            height: 42,
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              style: AppButtonStyle.textMajorButton,
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  AppRouter.names[AppRouterEnum.routerBuyerHomePage]!,
                );
              },
              child: Text("Войти", style: AppTextStyles.textButtonMajor),
            ),
          ),

          const SizedBox(height: 28),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                style: AppButtonStyle.textMinorButton,
                onPressed: () {},
                child: Text(
                  "Забыли пароль?",
                  style: AppTextStyles.textButtonMinor,
                ),
              ),

              TextButton(
                style: AppButtonStyle.textMinorButton,
                onPressed: () {},
                child: Text(
                  "Нет доступа к телефону / паролю",
                  style: AppTextStyles.textButtonMinor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
