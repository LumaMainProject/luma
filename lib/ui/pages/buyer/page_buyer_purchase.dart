import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma/domain/bloc/buyer_account_bloc.dart';
import 'package:luma/global/params/app_icons.dart';
import 'package:luma/global/params/app_text_styles.dart';

class PageBuyerPurchase extends StatelessWidget {
  const PageBuyerPurchase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BuyerAccountBloc, BuyerAccountState>(
        builder: (context, state) {
          if (state is! BuyerAccountLoaded) {
            return const Center(child: CircularProgressIndicator());
          }
          return CustomScrollView(
            slivers: [
              SliverAppBar(title: Text("Checkout")),

              SliverList.builder(
                itemCount: state.actualOrders.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListTile(
                      leading: Icon(AppIcons.appLogo),
                      title: Text(state.actualOrders[index].itemName),
                      trailing: Text(state.actualOrders[index].price.toString()),
                    ),
                  );
                },
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text("Total ${state.actualOrdersTotalPrice()}", style: AppTextStyles.title)],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Placeholder(),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Divider(),
                      Text("Delivery Fee", style: AppTextStyles.title),
                      Divider(),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text("PayMe", style: AppTextStyles.title2),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text("Click", style: AppTextStyles.title2),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text("Uzum", style: AppTextStyles.title2),
                          ),
                        ],
                      ),

                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
