import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma/domain/store_manager_bloc/store_manager_bloc.dart';
import 'package:luma/ui/widgets/widget_grid_view_promos.dart';
import 'package:luma/ui/widgets/widget_grid_view_suggested.dart';

class PageBuyerHomepageHome extends StatelessWidget {
  const PageBuyerHomepageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreManagerBloc, StoreManagerState>(
      builder: (context, state) {
        if (state is! StoreManagerLoaded) {
          return Center(child: CircularProgressIndicator());
        }

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [Text("Promos", style: TextStyle(fontSize: 18))],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: WidgetGridViewPromos(
                paddings: 16,
                itemList: state.itemsPromos,
                itemToShopDictionary: state.itemToShopDictionary,
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text("New Arrivals", style: TextStyle(fontSize: 18)),
              ),
            ),

            SliverToBoxAdapter(
              child: WidgetGridViewPromos(
                paddings: 16,
                itemList: state.itemsNewArrivals,
                itemToShopDictionary: state.itemToShopDictionary,
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Suggested for You",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: WidgetGridViewSuggested(
                  itemList: state.itemsSuggested,
                  itemToShopDictionary: state.itemToShopDictionary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
