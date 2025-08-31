import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/logic/user/user_bloc.dart';

class BuyerAccountOrders extends StatelessWidget {
  const BuyerAccountOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Заказы")),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            final inTrackOrders = state.user.inTrackOrders;

            if (inTrackOrders.isEmpty) {
              return const Center(child: Text("Нет текущих заказов"));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: inTrackOrders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final order = inTrackOrders[index];
                return Card(
                  child: ListTile(
                    title: Text("Товар ID: ${order.productId}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Количество: ${order.quantity}"),
                        Text("Сумма: ${order.totalPrice.toStringAsFixed(2)}"),
                        Text("Статус: ${order.status}"),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is UserError) {
            return Center(child: Text("Ошибка: ${state.message}"));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
