import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma/domain/buyer_bloc/buyer_account_bloc.dart';
import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/classes/object_shop.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_text_styles.dart';
import 'package:luma/ui/widgets/widget_store.dart';

class WidgetShopItemStack extends StatefulWidget {
  final ObjectShop shop;
  final List<ObjectItem> item;
  final Map<ObjectItem, ObjectShop> itemToShopDictionary;
  const WidgetShopItemStack({
    super.key,
    required this.item,
    required this.shop,
    required this.itemToShopDictionary,
  });

  @override
  State<WidgetShopItemStack> createState() => _WidgetShopItemStackState();
}

class _WidgetShopItemStackState extends State<WidgetShopItemStack> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuyerAccountBloc, BuyerAccountState>(
      builder: (context, state) {
        List<ObjectItem> objectItem = [];
        List<int> amount = [];

        for (int index = 0; index < widget.item.length; index++) {
          if (widget.itemToShopDictionary[widget.item[index]] == widget.shop) {
            if (objectItem.contains(widget.item[index])) {
              amount[objectItem.indexOf(widget.item[index])]++;
            } else {
              objectItem.add(widget.item[index]);
              amount.add(1);
            }
          }
        }

        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.fantasy,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),

          child: Column(
            children: [
              WidgetStore(
                store: widget.shop,
                color: AppColors.vanillaIce,
                itemToShopDictionary: widget.itemToShopDictionary,
              ),

              const SizedBox(height: 16),
              
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return WidgetShopItemStackItem(
                    item: objectItem[index],
                    amount: amount[index],
                  );
                },
                separatorBuilder: (context, index) => Column(
                  children: [
                    const SizedBox(height: 8),
                    const Divider(),
                    const SizedBox(height: 8),
                  ],
                ),
                itemCount: objectItem.length,
              ),
            ],
          ),
        );
      },
    );
  }
}

class WidgetShopItemStackItem extends StatefulWidget {
  final ObjectItem item;
  final int amount;
  const WidgetShopItemStackItem({
    super.key,
    required this.item,
    required this.amount,
  });

  @override
  State<WidgetShopItemStackItem> createState() =>
      _WidgetShopItemStackItemState();
}

class _WidgetShopItemStackItemState extends State<WidgetShopItemStackItem> {
  int amount = 0;

  @override
  Widget build(BuildContext context) {    
    if (amount == 0) {
      amount = widget.amount;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: const BorderRadiusGeometry.all(Radius.circular(16)),
          child: Image(
            image: widget.item.images[0],
            fit: BoxFit.fill,
            width: 80,
            height: 80,
          ),
        ),

        const SizedBox(width: 16),

        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(item.price.toString(), style: AppTextStyles.title),
              SizedBox(
                width: MediaQuery.of(context).size.width - 160,
                child: Text(
                  widget.item.itemName,
                  style: AppTextStyles.title,
                  maxLines: 1,
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width - 160,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Price", style: AppTextStyles.title2),
                    Text(
                      widget.item.price.toString(),
                      style: AppTextStyles.title2,
                    ),
                  ],
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width - 160,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Amount", style: AppTextStyles.title2),
                    Text(
                      "$amount",
                      style: AppTextStyles.title2,
                    ),
                  ],
                ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width - 160,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Final Price", style: AppTextStyles.title2),
                    Text(
                      "${widget.amount * widget.item.price}",
                      style: AppTextStyles.title2,
                    ),
                  ],
                ),
              ),

              // SizedBox(
              //   width: MediaQuery.of(context).size.width - 160,
              //   child: Row(
              //     children: [
              //       const Spacer(),

              //       IconButton(
              //         onPressed: () {
              //           bloc.add(RemoveActualOrdersEvent(item: widget.item));
              //           amount--;
              //           setState(() {});
              //         },
              //         icon: Icon(Icons.remove, color: AppColors.vanillaIce),
              //         style: IconButton.styleFrom(
              //           backgroundColor: AppColors.mainColor,
              //         ),
              //       ),

              //       const SizedBox(width: 16),

              //       Text(amount.toString(), style: AppTextStyles.title2),

              //       const SizedBox(width: 16),

              //       IconButton(
              //         onPressed: () {
              //           bloc.add(AddActualOrdersEvent(item: widget.item));
              //           amount++;
              //           setState(() {});
              //         },
              //         icon: Icon(Icons.add, color: AppColors.vanillaIce),
              //         style: IconButton.styleFrom(
              //           backgroundColor: AppColors.mainColor,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
