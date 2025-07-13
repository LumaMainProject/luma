import 'package:luma/global/classes/object_item.dart';
import 'package:luma/global/classes/object_shop.dart';
import 'package:luma/global/params/app_images.dart';

abstract class SaveLists{
  static final List<ObjectItem> itemList = [
    SaveItem.adidas_1,
    SaveItem.adidas_2,
    SaveItem.adidas_3,
    SaveItem.balenciaga_1,
    SaveItem.balenciaga_2,
    SaveItem.balenciaga_3,
    SaveItem.balenciaga_4,
    SaveItem.prada_1,
    SaveItem.prada_2,
    SaveItem.prada_3,
    SaveItem.prada_4,
  ];
}

abstract class SaveShop {
  static final ObjectShop adidas = ObjectShop(
    shopName: "Adidas",
    icon: AppImages.adidasImage,
    header: AppImages.adidasLogo,
    followers: 13000,
    rating: 4,
    // items: [
    //   SaveItem.adidas_1,
    //   SaveItem.adidas_2,
    //   SaveItem.adidas_3,
    // ]
  );

  static final ObjectShop prada = ObjectShop(
    shopName: "Prada",
    icon: AppImages.pradaImage,
    header: AppImages.pradaLogo,
    followers: 28000,
    rating: 5,
    // items: [
    //   SaveItem.prada_1,
    //   SaveItem.prada_2,
    //   SaveItem.prada_3,
    //   SaveItem.prada_4,
    // ]
  );

  static final ObjectShop balenciaga = ObjectShop(
    shopName: "Balenciaga",
    icon: AppImages.balenciagaImage,
    header: AppImages.balenciagaLogo,
    followers: 33000,
    rating: 3,
    // items: [
    //   SaveItem.balenciaga_1,
    //   SaveItem.balenciaga_2,
    //   SaveItem.balenciaga_3,
    //   SaveItem.balenciaga_4,
    // ]
  );
}

abstract class SaveItem {
  // ADIDAS
  static final ObjectItem adidas_1 = ObjectItem(
    itemName: "Adidas Кросовки",
    desctiption: "Описание",
    size: "43",
    images: [
      AppImages.adidasItem_1_1,
      AppImages.adidasItem_1_2,
      AppImages.adidasItem_1_3,
    ],
    shop: SaveShop.adidas,
    brand: "Adidas",
    price: 399000,
    quantity: 49,
    reviews: 4,
  );

  static final ObjectItem adidas_2 = ObjectItem(
    itemName: "Adidas Кросовки",
    desctiption: "Описание",
    size: "43",
    images: [
      AppImages.adidasItem_2_1,
      AppImages.adidasItem_2_2,
      AppImages.adidasItem_2_3,
    ],
    shop: SaveShop.adidas,
    brand: "Adidas",
    price: 399000,
    quantity: 49,
    reviews: 4,
  );

  static final ObjectItem adidas_3 = ObjectItem(
    itemName: "Adidas Кросовки",
    desctiption: "Описание",
    size: "43",
    images: [
      AppImages.adidasItem_3_1,
      AppImages.adidasItem_3_2,
      AppImages.adidasItem_3_3,
    ],
    shop: SaveShop.adidas,
    brand: "Adidas",
    price: 399000,
    quantity: 49,
    reviews: 4,
  );

  // PRADA
  static final ObjectItem prada_1 = ObjectItem(
    itemName: "Prada Кросовки",
    desctiption: "Описание",
    size: "43",
    images: [
      AppImages.pradaItem_1_1,
      AppImages.pradaItem_1_2,
      AppImages.pradaItem_1_3,
    ],
    shop: SaveShop.prada,
    brand: "Prada",
    price: 399000,
    quantity: 49,
    reviews: 4,
  );

  static final ObjectItem prada_2 = ObjectItem(
    itemName: "Prada Кросовки",
    desctiption: "Описание",
    size: "43",
    images: [
      AppImages.pradaItem_2_1,
      AppImages.pradaItem_2_2,
    ],
    shop: SaveShop.prada,
    brand: "Prada",
    price: 399000,
    quantity: 49,
    reviews: 4,
  );

  static final ObjectItem prada_3 = ObjectItem(
    itemName: "Prada Кросовки",
    desctiption: "Описание",
    size: "43",
    images: [
      AppImages.pradaItem_3_1,
      AppImages.pradaItem_3_2,
      AppImages.pradaItem_3_3,
    ],
    shop: SaveShop.prada,
    brand: "Prada",
    price: 399000,
    quantity: 49,
    reviews: 4,
  );

    static final ObjectItem prada_4 = ObjectItem(
    itemName: "Prada Кросовки",
    desctiption: "Описание",
    size: "43",
    images: [
      AppImages.pradaItem_4_1,
      AppImages.pradaItem_4_2,
    ],
    shop: SaveShop.prada,
    brand: "Prada",
    price: 399000,
    quantity: 49,
    reviews: 4,
  );

  // BALENCIAGA
  static final ObjectItem balenciaga_1 = ObjectItem(
    itemName: "Balenciaga Кросовки",
    desctiption: "Описание",
    size: "43",
    images: [
      AppImages.balenciagaItem_1_1,
      AppImages.balenciagaItem_1_2,
      AppImages.balenciagaItem_1_3,
    ],
    shop: SaveShop.balenciaga,
    brand: "Balenciaga",
    price: 399000,
    quantity: 49,
    reviews: 4,
  );

  static final ObjectItem balenciaga_2 = ObjectItem(
    itemName: "Balenciaga Кросовки",
    desctiption: "Описание",
    size: "43",
    images: [
      AppImages.balenciagaItem_2_1,
      AppImages.balenciagaItem_2_2,
    ],
    shop: SaveShop.balenciaga,
    brand: "Balenciaga",
    price: 399000,
    quantity: 49,
    reviews: 4,
  );

  static final ObjectItem balenciaga_3 = ObjectItem(
    itemName: "Balenciaga Кросовки",
    desctiption: "Описание",
    size: "43",
    images: [
      AppImages.balenciagaItem_3_1,
      AppImages.balenciagaItem_3_2,
    ],
    shop: SaveShop.balenciaga,
    brand: "Balenciaga",
    price: 399000,
    quantity: 49,
    reviews: 4,
  );

    static final ObjectItem balenciaga_4 = ObjectItem(
    itemName: "Balenciaga Кросовки",
    desctiption: "Описание",
    size: "43",
    images: [
      AppImages.balenciagaItem_4_1,
      AppImages.balenciagaItem_4_2,
      AppImages.balenciagaItem_4_3,
    ],
    shop: SaveShop.balenciaga,
    brand: "Balenciaga",
    price: 399000,
    quantity: 49,
    reviews: 4,
  );
}
