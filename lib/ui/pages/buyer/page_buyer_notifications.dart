import 'package:flutter/material.dart';
import 'package:luma/global/params/app_icons.dart';

class PageBuyerNotifications extends StatelessWidget {
  const PageBuyerNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Notifications"),
      ),

      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(AppIcons.account),
            title: Text("Title"),
            subtitle: Text("Subtitle"),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.list)),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: 20,
      ),
    );
  }
}
