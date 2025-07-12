import 'package:flutter/material.dart';
import 'package:luma/global/app_icons.dart';
import 'package:luma/ui/pages/buyer/page_buyer_homepage.dart';

class PageRegister extends StatelessWidget {
  const PageRegister({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> listViewWidgets = [
      Text("Registration", style: TextStyle(fontSize: 24)),
      TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          label: Text("Phone Number"),
        ),
        keyboardType: TextInputType.number,
      ),
      SizedBox(
        height: 56,
        child: FilledButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PageBuyerHomepage(),
              ),
            );
          },
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
            ),
          ),
          child: Text("Send code", style: TextStyle(fontSize: 16)),
        ),
      ),
      Divider(),
      Row(
        children: [
          IconButton(onPressed: () {}, icon: Icon(AppIcons.googleIcon)),
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Spacer(),
          ListView.separated(
            itemBuilder: (context, index) {
              return listViewWidgets[index];
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemCount: listViewWidgets.length,
            shrinkWrap: true,
            padding: EdgeInsets.all(32),
          ),
          SizedBox(height: 50),
          Spacer(),
        ],
      ),
    );
  }
}
