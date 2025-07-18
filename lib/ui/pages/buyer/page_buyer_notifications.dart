import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma/domain/buyer_bloc/buyer_account_bloc.dart';
import 'package:luma/ui/widgets/widget_buyer_notification.dart';

class PageBuyerNotifications extends StatelessWidget {
  const PageBuyerNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BuyerAccountBloc, BuyerAccountState>(
      builder: (context, state) {
        if (state is! BuyerAccountLoaded) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            //backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text("Notifications"),
          ),

          body: state.notifications.isEmpty
              ? const Center(child: Text("Похоже у вас нет оповещений"))
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: WidgetBuyerNotification(
                        notification: state.notifications[index],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: state.notifications.length,
                ),
        );
      },
    );
  }
}
