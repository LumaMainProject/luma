import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/core/constants/app_icons.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/core/theme/app_sizes.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/core/theme/app_text_styles.dart';
import 'package:luma_2/presentation/widgets/item_widget.dart';
import 'package:luma_2/presentation/widgets/shop_widget.dart';
import 'package:luma_2/logic/user/user_bloc.dart';
import 'package:luma_2/logic/products/products_cubit.dart';
import 'package:luma_2/data/models/product.dart';
import 'package:luma_2/data/models/user_profile.dart';

class BuyerPurchaseScreen extends StatefulWidget {
  const BuyerPurchaseScreen({super.key});

  @override
  State<BuyerPurchaseScreen> createState() => _BuyerPurchaseScreenState();
}

class _BuyerPurchaseScreenState extends State<BuyerPurchaseScreen> {
  bool confirmItems = false;
  bool confirmAddress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Оформление заказа")),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          if (userState is! UserLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = userState.user.currentOrders;

          return BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, productsState) {
              if (productsState is! ProductsLoaded) {
                return const Center(child: CircularProgressIndicator());
              }

              if (orders.isEmpty) {
                return const Center(child: Text("Корзина пуста"));
              }

              final totalPrice = orders.fold<double>(
                0,
                (sum, o) => sum + o.totalPrice,
              );

              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSpacing.paddingMd),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _OrderItemsCard(
                          orders: orders,
                          products: productsState.products,
                          value: confirmItems,
                          onChanged: (v) => setState(() => confirmItems = v),
                        ),
                        const SizedBox(height: AppSpacing.paddingMd),
                        _AddressCard(
                          value: confirmAddress,
                          onChanged: (v) => setState(() => confirmAddress = v),
                        ),
                        const SizedBox(height: AppSpacing.paddingMd),
                        Text("Способ доставки", style: AppTextStyles.headline),
                        const SizedBox(height: AppSpacing.paddingMd),
                        const BuyerPurchaseScreenDeliveryOptions(),
                        const SizedBox(height: AppSpacing.paddingMd),
                        Text("Способ оплаты", style: AppTextStyles.headline),
                        const SizedBox(height: AppSpacing.paddingMd),
                        const BuyerPurchaseScreenPaymentOptions(),
                        const SizedBox(height: AppSpacing.bottomButtonBar),
                      ],
                    ),
                  ),

                  _BottomSummaryBar(
                    totalPrice: totalPrice,
                    enabled: confirmItems && confirmAddress,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

// -------------------- ORDER ITEMS --------------------

// -------------------- ORDER ITEMS --------------------

class _OrderItemsCard extends StatelessWidget {
  final List<CurrentOrder> orders;
  final List<Product> products;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _OrderItemsCard({
    required this.orders,
    required this.products,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Товары в заказе (${orders.length})",
              style: AppTextStyles.headline,
            ),
            const SizedBox(height: AppSpacing.paddingMd),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: orders.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.paddingSm),
              itemBuilder: (context, index) {
                final order = orders[index];
                final product = products.firstWhere(
                  (p) => p.id == order.productId,
                );
                return ShopWidgetItem(item: MapEntry(product, order));
              },
            ),
            const SizedBox(height: AppSpacing.paddingMd),
            Row(
              children: [
                Checkbox(value: value, onChanged: (v) => onChanged(v ?? false)),
                const Expanded(
                  child: Text(
                    "Подтверждаю, что выбранные товары и размеры верны",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------- ADDRESS --------------------

class _AddressCard extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _AddressCard({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Адрес доставки", style: AppTextStyles.headline),
            const SizedBox(height: AppSpacing.paddingMd),
            Row(
              children: [
                SizedBox(
                  height: 80,
                  width: 140,
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: const Center(child: Icon(AppIcons.gps)),
                  ),
                ),
                const SizedBox(width: AppSpacing.paddingMd),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Основной адрес", style: AppTextStyles.headline),
                      Text(
                        "Ташкент, ул. Амира Темура, 15, кв. 24, Подъезд 2, домофон 24",
                        style: AppTextStyles.text,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.paddingMd),
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Изменить",
                    style: AppTextStyles.text.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.paddingMd),
                TextButton(
                  onPressed: () {},
                  child: const Text("Добавить новый"),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(value: value, onChanged: (v) => onChanged(v ?? false)),
                const Expanded(
                  child: Text("Подтверждаю, что адрес указан верно"),
                ),
              ],
            ),
            const Text(
              "Курьер позвонит перед доставкой",
              style: AppTextStyles.textButton,
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------- DELIVERY OPTIONS --------------------

class BuyerPurchaseScreenDeliveryOptions extends StatefulWidget {
  const BuyerPurchaseScreenDeliveryOptions({super.key});

  @override
  State<BuyerPurchaseScreenDeliveryOptions> createState() =>
      _BuyerPurchaseScreenDeliveryOptionsState();
}

class _BuyerPurchaseScreenDeliveryOptionsState
    extends State<BuyerPurchaseScreenDeliveryOptions> {
  int active = 0;

  void _setActive(int index) => setState(() => active = index);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuyerPurchaseScreenButton(
          title: "Экспресс 1-2 часа",
          subtitle: "до 16:00",
          tag: "Сегодня",
          price: "+30.000 сум",
          isActive: active == 0,
          function: () => _setActive(0),
        ),
        const SizedBox(height: AppSpacing.paddingMd),
        BuyerPurchaseScreenButton(
          title: "Быстрая 3-4 часа",
          subtitle: "до 18:00",
          price: "+15.000 сум",
          isActive: active == 1,
          function: () => _setActive(1),
        ),
        const SizedBox(height: AppSpacing.paddingMd),
        BuyerPurchaseScreenButton(
          title: "Обычная 5-6 часа",
          subtitle: "до 21:00",
          price: "+10.000 сум",
          isActive: active == 2,
          function: () => _setActive(2),
        ),
      ],
    );
  }
}

class BuyerPurchaseScreenButton extends StatelessWidget {
  final void Function()? function;
  final String? tag;
  final String title;
  final String subtitle;
  final String price;
  final bool isActive;

  const BuyerPurchaseScreenButton({
    super.key,
    this.function,
    this.tag,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        backgroundColor: isActive
            ? AppColors.primary.withAlpha(25)
            : AppColors.white,
      ),
      onPressed: function,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.paddingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title, style: AppTextStyles.cardMainText),
                if (tag != null) ...[
                  const SizedBox(width: AppSpacing.paddingSm),
                  ItemWidgetTag(text: tag!),
                ],
                const Spacer(),
                Text(price, style: AppTextStyles.buttonActive),
              ],
            ),
            Text(subtitle, style: AppTextStyles.textButton),
          ],
        ),
      ),
    );
  }
}

// -------------------- PAYMENT --------------------

class BuyerPurchaseScreenPaymentOptions extends StatefulWidget {
  const BuyerPurchaseScreenPaymentOptions({super.key});

  @override
  State<BuyerPurchaseScreenPaymentOptions> createState() =>
      _BuyerPurchaseScreenPaymentOptionsState();
}

class _BuyerPurchaseScreenPaymentOptionsState
    extends State<BuyerPurchaseScreenPaymentOptions> {
  bool isCash = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Row(
        children: [
          _PaymentOption(
            title: "Наличные",
            icon: AppIcons.buyer,
            isActive: isCash,
            onTap: () => setState(() => isCash = true),
          ),
          AppSpacing.horizontalMd,
          _PaymentOption(
            title: "Картой",
            icon: AppIcons.seller,
            isActive: !isCash,
            onTap: () => setState(() => isCash = false),
          ),
        ],
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _PaymentOption({
    required this.title,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          backgroundColor: isActive
              ? AppColors.primary.withAlpha(25)
              : AppColors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: AppSizes.avatarSm),
            const SizedBox(height: AppSpacing.paddingSm),
            Text(title),
          ],
        ),
      ),
    );
  }
}

// -------------------- BOTTOM BAR --------------------

class _BottomSummaryBar extends StatelessWidget {
  final double totalPrice;
  final bool enabled;

  const _BottomSummaryBar({required this.totalPrice, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: AppSpacing.bottomNavBar,
        margin: const EdgeInsets.all(AppSpacing.paddingMd),
        decoration: BoxDecoration(
          color: Colors.white,
          border: BoxBorder.all(color: AppColors.borderColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(AppSizes.buttonRadius),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.paddingMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(AppSizes.buttonRadius),
            ),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("ИТОГО"),
                  Text("$totalPrice сум", style: AppTextStyles.headline),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: enabled ? () {} : null,
                  child: const Text("Заказать"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
