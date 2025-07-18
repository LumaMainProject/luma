import 'package:flutter/material.dart';
import 'package:luma/global/params/app_colors.dart';

class PageBuyerSearch extends StatefulWidget {
  const PageBuyerSearch({super.key});

  @override
  State<PageBuyerSearch> createState() => _PageBuyerSearchState();
}

class _PageBuyerSearchState extends State<PageBuyerSearch> {
  @override
  Widget build(BuildContext context) {
    SearchController searchController = SearchController();

    final List<String> tags = [
      "Кроссовки",
      "Платья",
      "Юбки",
      "Кеды",
      "Кольца",
      "Тоналки",
      "Макияж",
      "Браслеты",
      "Сумочки",
      "Рюкзаки",
    ];

    final List<String> sizes = [
      "Красный",
      "Желтый",
      "Зеленый",
      "Синий",
      "Белый",
      "Черный",
      "Фиолетовый",
      "Оранжевый",
      "Розовый",
      "Голубой",
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Search")),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SearchBar(
                controller: searchController,
                leading: const Icon(Icons.search),
                hintText: "Search",
                elevation: const WidgetStatePropertyAll(0),
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
          ),

          SliverToBoxAdapter(child: SearchTags(tags: tags)),

          SliverToBoxAdapter(child: SearchTags(tags: sizes)),

          SliverToBoxAdapter(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: SearchBlocsList(),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: SearchBlocsList(isLeft: false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchTags extends StatefulWidget {
  final List<String> tags;
  const SearchTags({super.key, required this.tags});

  @override
  State<SearchTags> createState() => _SearchTagsState();
}

class _SearchTagsState extends State<SearchTags> {
  final ButtonStyle active = TextButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
    ),
    side: BorderSide(color: AppColors.mainColor),
    backgroundColor: AppColors.vanillaIce,
  );

  final ButtonStyle deactive = TextButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
    ),
    side: BorderSide(color: AppColors.mainColor),
  );

  late List<String> tags;

  List<bool> tagsActive = [];

  @override
  Widget build(BuildContext context) {
    tags = widget.tags;

    if (tagsActive.isEmpty) {
      tagsActive = List.generate(tags.length, (index) => false);
    }
    return AspectRatio(
      aspectRatio: 5,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return TextButton(
            onPressed: () {
              tagsActive[index] = !tagsActive[index];
              setState(() {});
            },
            style: tagsActive[index] ? active : deactive,
            child: Text(tags[index]),
          );
        },
        itemCount: tags.length,
      ),
    );
  }
}

class SearchBlocsList extends StatelessWidget {
  final bool isLeft;
  const SearchBlocsList({super.key, this.isLeft = true});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        top: 8,
        bottom: 8,
        left: isLeft ? 16 : 8,
        right: isLeft ? 8 : 16,
      ),
      itemBuilder: (context, index) => SearchBlocsListItem(),
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: 10,
    );
  }
}

class SearchBlocsListItem extends StatelessWidget {
  const SearchBlocsListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.vanillaIce,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}
