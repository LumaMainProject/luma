import 'package:flutter/material.dart';
import 'package:luma/global/params/app_colors.dart';
import 'package:luma/global/params/app_images.dart';
import 'package:luma/ui/pages/buyer/page_buyer_homepage.dart';
import 'package:luma/ui/pages/seller/page_seller_homepage.dart';

class PageRegister extends StatefulWidget {
  final int changeTheme;
  const PageRegister({super.key, this.changeTheme = 0});

  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  @override
  Widget build(BuildContext context) {
    List<Widget> listViewWidgets = [
      Image(image: AppImages.appLogo),

      // TextField(
      //   decoration: InputDecoration(
      //     border: OutlineInputBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(16)),
      //     ),
      //     label: Text("Phone Number"),
      //   ),
      //   keyboardType: TextInputType.number,
      // ),
      Align(
        alignment: Alignment.center,
        child: Text(
          "LUMA",
          style: TextStyle(fontSize: 28, color: AppColors.mainColor),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: Text("Choose account", style: TextStyle(fontSize: 24, color: AppColors.mainColor)),
      ),

      SizedBox(
        height: 56,
        child: FilledButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const PageBuyerHomepage(),
              ),
              (Route<dynamic> route) => false,
            );
          },
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
            ),
          ),
          child: Text("Buyer", style: TextStyle(fontSize: 16)),
        ),
      ),

      SizedBox(
        height: 56,
        child: FilledButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const PageSellerHomepage(),
              ),
              (Route<dynamic> route) => false,
            );
          },
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
            ),
          ),
          child: Text("Seller", style: TextStyle(fontSize: 16)),
        ),
      ),

      //Divider(),
      // Row(
      //   children: [
      //     IconButton(onPressed: () {}, icon: Icon(AppIcons.googleIcon)),
      //   ],
      // ),
    ];

    return Scaffold(
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
