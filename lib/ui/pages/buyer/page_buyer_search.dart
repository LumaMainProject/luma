import 'package:flutter/material.dart';

class PageBuyerSearch extends StatelessWidget {
  const PageBuyerSearch({super.key});

  @override
  Widget build(BuildContext context) {
    SearchController searchController = SearchController();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SearchBar(
          controller: searchController,
          leading: const Icon(Icons.search),
          hintText: "Search",
          elevation: WidgetStatePropertyAll(0),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
            ),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 16),
          ),

          onSubmitted: (value) {},
          onTapOutside: (event) {},
        ),
      ),
    );
  }
}
