import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma/domain/buyer_bloc/buyer_account_bloc.dart';
import 'package:luma/global/classes/object_user.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_images.dart';
import 'package:luma/global/params/app_text_styles.dart';

class PageBuyerProfile extends StatelessWidget {
  const PageBuyerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuyerAccountBloc, BuyerAccountState>(
      builder: (context, state) {
        if (state is! BuyerAccountLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        String date = state.birthdate != null
            ? "${state.birthdate!.day} ${state.birthdate!.month} ${state.birthdate!.year}"
            : "Your birthdate";

        return Scaffold(
          appBar: AppBar(
            title: Text("Profile"),
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: ClipRRect(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
              child: Container(color: Colors.transparent),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      //border: BoxBorder.all(),
                      borderRadius: BorderRadiusGeometry.all(
                        Radius.circular(16),
                      ),
                      color: AppColors.vanillaIce
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadiusGeometry.all(
                            Radius.circular(16),
                          ),
                          child: Container(
                            width: 120,
                            height: 120,
                            color: Colors.amber,
                            child: Image(
                              image: state.avatar ?? AppImages.adidasImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              state.name ?? "Name",
                              style: AppTextStyles.title,
                            ),
                            Text(
                              state.gender == Gender.male ? "Male" : "Female",
                              style: AppTextStyles.title2,
                            ),
                            Text(date, style: AppTextStyles.title2),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Text("Sizes", style: AppTextStyles.title2),
                      SizedBox(height: 16),
                    ],
                  ),
                ),

                const SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Text("Interests", style: AppTextStyles.title2),
                      SizedBox(height: 16),
                    ],
                  ),
                ),

                const SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Text("Following", style: AppTextStyles.title2),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
