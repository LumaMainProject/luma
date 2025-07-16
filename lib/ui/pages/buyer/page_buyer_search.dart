import 'package:flutter/material.dart';

class PageBuyerSearch extends StatefulWidget {
  const PageBuyerSearch({super.key});

  @override
  State<PageBuyerSearch> createState() => _PageBuyerSearchState();
}

class _PageBuyerSearchState extends State<PageBuyerSearch> {
  @override
  Widget build(BuildContext context) {
    SearchController searchController = SearchController();

    return Scaffold(
      appBar: AppBar(title: Text("Search")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SearchBar(
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
          ],
        ),
      ),
    );
  }
}
