import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/core/theme/app_spacing.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/logic/multi_store_orders/multi_store_orders_bloc.dart';
import 'package:luma_2/presentation/widgets/seller/seller_order_widget.dart';

class SellerHomepageScreenOrders extends StatefulWidget {
  final Store store;
  const SellerHomepageScreenOrders({super.key, required this.store});

  @override
  State<SellerHomepageScreenOrders> createState() =>
      _SellerHomepageScreenOrdersState();
}

class _SellerHomepageScreenOrdersState
    extends State<SellerHomepageScreenOrders> {
  @override
  void initState() {
    super.initState();
    // Загружаем заказы для этого магазина
    context.read<MultiStoreOrdersBloc>().add(LoadStoreOrders(widget.store.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MultiStoreOrdersBloc, MultiStoreOrdersState>(
        builder: (context, state) {
          if (state is MultiStoreOrdersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MultiStoreOrdersLoaded) {
            final orders = state.ordersByStore[widget.store.id] ?? [];

            if (orders.isEmpty) {
              return const Center(child: Text("Нет заказов"));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length + 1,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                if(index == orders.length){
                  return const SizedBox(height: AppSpacing.bottomNavBar);
                }
                return SellerOrderWidget(order: orders[index]);
              }
            );
          } else if (state is MultiStoreOrdersError) {
            return Center(child: Text("Ошибка: ${state.message}"));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
