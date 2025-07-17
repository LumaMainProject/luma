import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma/domain/store_manager_bloc/store_manager_bloc.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/saves/saves.dart';
import 'package:luma/ui/widgets/widget_feed_container.dart';

class PageBuyerHomepageFeed extends StatelessWidget {
  const PageBuyerHomepageFeed({super.key});

  @override
  Widget build(BuildContext context) {
    //final CarouselController carouselController = CarouselController();
    List<ObjectItem> list = [];
    //int _currentIndex = carouselController.initialItem;

    final PageController pageController = PageController();

    return BlocBuilder<StoreManagerBloc, StoreManagerState>(
      builder: (context, state) {
        if (state is! StoreManagerLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        list = state.itemsPromos;

        return PageView.builder(
          controller: pageController,
          onPageChanged: (value) {
            // int previousPage = _currentIndex;
            // if (_currentIndex != 0)
            //   previousPage--;
            // else
            //   previousPage = 2;
          },
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: WidgetFeedContainer(
                itemToShopDictionary: state.itemToShopDictionary,
                shop:
                    state.itemToShopDictionary[list[index]] ?? SaveShop.adidas,
                item: list[index],
                page: pageController.page?.toInt() ?? 0,
              ),
            );
          },
          itemCount: list.length,
          scrollDirection: Axis.vertical,
        );
      },
    );

    // return CarouselView.weighted(
    //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //   controller: carouselController,
    //   flexWeights: [1],
    //   scrollDirection: Axis.vertical,
    //   shape: OutlineInputBorder(
    //     borderRadius: BorderRadius.all(Radius.zero),
    //     borderSide: BorderSide.none,
    //   ),
    //   itemSnapping: true,
    //   enableSplash: false,

    //   children: List.generate(
    //     list.length,
    //     (index) =>
    //         WidgetFeedContainer(shop: list[index].shop, item: list[index]),
    //   ),
    // );
  }
}
