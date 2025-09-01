import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/logic/multi_store_orders/multi_store_orders_bloc.dart';

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
    context
        .read<MultiStoreOrdersBloc>()
        .add(LoadStoreOrders(widget.store.id));
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
              itemCount: orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final order = orders[index];
                return Text(
                  "Заказ: ${order.productId} | Кол-во: ${order.quantity} | Статус: ${order.status}",
                  style: const TextStyle(fontSize: 16),
                );
              },
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
