import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma/domain/seller_bloc/seller_account_bloc.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/widgets/widget_seller_item_card_statistic.dart';

class PageSellerHomepageHome extends StatelessWidget {
  const PageSellerHomepageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerAccountBloc, SellerAccountState>(
      builder: (context, state) {
        if (state is! SellerAccountLoaded) {
          return const Center(child: CircularProgressIndicator());
        }
        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text("Top Sellers", style: AppTextStyles.title),
              ),
            ),

            SliverList.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: WidgetSellerItemCardStatistic(item: state.items[index],),
                );
              },
              itemCount: state.items.length,
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    minimumSize: Size(0, 80),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.all(
                        Radius.circular(16),
                      ),
                    ),
                  ),
                  child: Text("BOOST", style: AppTextStyles.title),
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text("Statistic", style: AppTextStyles.title),
              ),
            ),

            SliverList.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: WidgetSellerItemCardStatistic(item: state.items[index],),
                );
              },
              itemCount: state.items.length,
            ),
          ],
        );
      },
    );
  }
}
