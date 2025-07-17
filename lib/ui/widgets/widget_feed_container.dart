import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma/domain/manager_bloc/manager_bloc.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/classes/object_shop.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/ui/pages/buyer/page_buyer_item_card.dart';
import 'package:luma/ui/widgets/widget_store.dart';
import 'package:video_player/video_player.dart';

class WidgetFeedContainer extends StatelessWidget {
  final int page;
  final ObjectShop shop;
  final ObjectItem item;
  final Map<ObjectItem, ObjectShop> itemToShopDictionary;
  const WidgetFeedContainer({
    super.key,
    required this.page,
    required this.shop,
    required this.item,
    required this.itemToShopDictionary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: BoxBorder.all(color: Theme.of(context).hoverColor),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Stack(
        children: [
          // VIDEO
          WidgetFeedVideoPlayer(page: page, video: shop.video),

          // ITEM
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: AppColors.vanillaIce,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.all(
                        Radius.circular(16),
                      ),
                    ),
                    leading: ClipRRect(
                      borderRadius: const BorderRadiusGeometry.all(
                        Radius.circular(16),
                      ),
                      child: Image(
                        fit: BoxFit.cover,
                        image: item.images[0],
                        height: 50,
                        width: 50,
                      ),
                    ),
                    title: Text(item.itemName),
                    subtitle: Text(item.brand),
                    trailing: Text(item.price.toString()),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageBuyerItemCard(
                            shop: shop,
                            index: shop.items.indexOf(item),
                            itemToShopDictionary: itemToShopDictionary,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          //STORE
          Align(
            alignment: Alignment.topCenter,
            child: WidgetStore(
              blurLevel: 5,
              store: shop,
              itemToShopDictionary: itemToShopDictionary,
            ),
          ),
        ],
      ),
    );
  }
}

class WidgetFeedVideoPlayer extends StatefulWidget {
  final int page;
  final String video;
  const WidgetFeedVideoPlayer({
    super.key,
    required this.page,
    required this.video,
  });

  @override
  State<WidgetFeedVideoPlayer> createState() => _WidgetFeedVideoPlayerState();
}

class _WidgetFeedVideoPlayerState extends State<WidgetFeedVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.video)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagerBloc, ManagerState>(
      builder: (context, state) {
        if (state is! ManagerLoaded) {
          return Center(child: CircularProgressIndicator());
        }

        // if (state.currentPage == 0) {
        //   _controller.play();
        //   _controller.setLooping(true);
        // }

        if (state.currentPage != 0) {
          _controller.pause();
        }

        return Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : const CircularProgressIndicator(),
        );
      },
    );
  }
}
