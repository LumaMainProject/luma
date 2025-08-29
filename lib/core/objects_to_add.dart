import 'package:luma_2/data/models/product.dart';
import 'package:luma_2/data/models/review.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/data/models/user_profile.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ObjectsToAdd {
  final stores = [
    Store(
      id: "store_1",
      name: "TechnoShop",
      description: "Гаджеты и электроника",
      ownerId: "user_1",
      category: "Электроника",
      productIds: ["prod_1", "prod_2"],
      logoUrl: "https://picsum.photos/200/200?random=11",
      bannerUrl: "https://picsum.photos/800/400?random=12",
    ),
    Store(
      id: "store_2",
      name: "FashionLine",
      description: "Одежда и аксессуары",
      ownerId: "user_1",
      category: "Одежда",
      productIds: ["prod_3", "prod_4"],
      logoUrl: "https://picsum.photos/200/200?random=13",
      bannerUrl: "https://picsum.photos/800/400?random=14",
    ),
  ];

  final products = [
    Product(
      id: "prod_1",
      title: "Смартфон Samsung Galaxy S23",
      name: "Samsung Galaxy S23",
      description: "Флагманский смартфон с мощной камерой",
      article: "SGS23-001",
      category: "Электроника",
      type: "Смартфон",
      brand: "Samsung",
      countryOfOrigin: "Корея",
      discountPrice: 1500000.0,
      price: 950000.0,
      imageUrl: "https://picsum.photos/800/400?random=1",
      sellerId: "store_1",
      stock: 15,
      rating: 4.8,
      ratingCount: 120,
      favoritesCount: 85,
      ordersCount: 240,
      specs: {
        "Дисплей": "6.1\" AMOLED, 120Hz",
        "Камера": "50MP + 12MP + 10MP",
        "Батарея": "3900 мАч",
        "Память": "8GB RAM, 256GB ROM",
        "Процессор": "Snapdragon 8 Gen 2",
      },
      reviews: [
        Review(
          userId: "user_2",
          userName: "Анна Смирнова",
          text: "Камера просто супер, батарея держит долго!",
          rating: 5,
          createdAt: Timestamp.now(),
        ),
        Review(
          userId: "user_3",
          userName: "Олег Иванов",
          text: "Отличный смартфон, но дороговато.",
          rating: 4,
          createdAt: Timestamp.now(),
        ),
        Review(
          userId: "user_4",
          userName: "Мария Соколова",
          text: "Пользуюсь 2 месяца – всё летает.",
          rating: 5,
          createdAt: Timestamp.now(),
        ),
      ],
    ),
    Product(
      id: "prod_2",
      title: "Наушники Sony WH-1000XM5",
      name: "Sony WH-1000XM5",
      description: "Беспроводные наушники с шумоподавлением",
      article: "SONY-WH1000XM5",
      category: "Аудио",
      type: "Наушники",
      brand: "Sony",
      countryOfOrigin: "Япония",
      price: 400000.0,
      imageUrl: "https://picsum.photos/800/400?random=2",
      sellerId: "store_1",
      stock: 30,
      rating: 4.7,
      ratingCount: 250,
      favoritesCount: 190,
      ordersCount: 430,
      specs: {
        "Тип": "Bluetooth 5.2",
        "Шумоподавление": "Активное (ANC)",
        "Время работы": "30 часов",
        "Вес": "250 г",
        "Поддержка кодеков": "LDAC, AAC, SBC",
      },
      reviews: [
        Review(
          userId: "user_2",
          userName: "Анна Смирнова",
          text: "Шумодав шикарный, лучшее что пробовала!",
          rating: 5,
          createdAt: Timestamp.now(),
        ),
        Review(
          userId: "user_5",
          userName: "Дмитрий Павлов",
          text: "Звук топовый, но пластик маркий.",
          rating: 4,
          createdAt: Timestamp.now(),
        ),
      ],
    ),
    Product(
      id: "prod_3",
      title: "Футболка Nike Air",
      name: "Nike Air T-Shirt",
      description: "Спортивная футболка Nike из дышащей ткани",
      article: "NIKE-TSHIRT-AIR",
      category: "Одежда",
      type: "Футболка",
      brand: "Nike",
      countryOfOrigin: "Китай",
      price: 35000.0,
      discountPrice: 40000.0,
      imageUrl: "https://picsum.photos/800/400?random=3",
      sellerId: "store_2",
      stock: 100,
      sizes: ["S", "M", "L", "XL"],
      colors: ["Белый", "Черный"],
      rating: 4.5,
      ratingCount: 75,
      favoritesCount: 50,
      ordersCount: 180,
      specs: {
        "Материал": "100% хлопок",
        "Сезон": "Лето",
        "Фасон": "Классический",
        "Вес": "200 г",
        "Уход": "Машинная стирка",
      },
      reviews: [
        Review(
          userId: "user_3",
          userName: "Олег Иванов",
          text: "Материал приятный, удобно сидит.",
          rating: 5,
          createdAt: Timestamp.now(),
        ),
        Review(
          userId: "user_6",
          userName: "Светлана Ким",
          text: "После стирки немного села.",
          rating: 4,
          createdAt: Timestamp.now(),
        ),
      ],
    ),
    Product(
      id: "prod_4",
      title: "Кроссовки Adidas Ultraboost",
      name: "Adidas Ultraboost",
      description: "Легкие беговые кроссовки с отличной амортизацией",
      article: "ADIDAS-UB-2023",
      category: "Одежда",
      type: "Кроссовки",
      brand: "Adidas",
      countryOfOrigin: "Вьетнам",
      price: 150000.0,
      imageUrl: "https://picsum.photos/800/400?random=4",
      sellerId: "store_2",
      stock: 50,
      sizes: ["38", "39", "40", "41", "42", "43"],
      colors: ["Черный", "Синий"],
      rating: 4.6,
      ratingCount: 180,
      favoritesCount: 130,
      ordersCount: 320,
      specs: {
        "Материал": "Текстиль + подошва Boost",
        "Назначение": "Беговые",
        "Вес": "310 г",
        "Особенности": "Амортизация Boost, сетчатый верх",
        "Страна производства": "Вьетнам",
      },
      reviews: [
        Review(
          userId: "user_4",
          userName: "Мария Соколова",
          text: "Очень удобные для бега, ноги не устают.",
          rating: 5,
          createdAt: Timestamp.now(),
        ),
        Review(
          userId: "user_7",
          userName: "Алексей Королев",
          text: "Немного жмут по ширине, но привык.",
          rating: 4,
          createdAt: Timestamp.now(),
        ),
      ],
    ),
  ];

  final users = [
    UserProfile(
      id: "user_1",
      name: "Иван Петров",
      emails: ["tester@example.com"],
      phones: ["+998901112233"],
      role: "seller",
      avatarUrl: "https://i.pravatar.cc/150?img=1",
      currentOrders: [
        CurrentOrder(
          id: "order_1",
          productId: "prod_2",
          storeId: "store_1",
          quantity: 4,
          selectedColor: "Черный",
          selectedSize: null,
          unitPrice: 400000.0,
          totalPrice: 1600000.0,
          status: "pending",
        ),
        CurrentOrder(
          id: "order_2",
          productId: "prod_1",
          storeId: "store_1",
          quantity: 2,
          selectedColor: "Черный",
          selectedSize: null,
          unitPrice: 950000.0,
          totalPrice: 1900000.0,
          status: "pending",
        ),
        CurrentOrder(
          id: "order_3",
          productId: "prod_3",
          storeId: "store_2",
          quantity: 1,
          selectedColor: "Черный",
          selectedSize: null,
          unitPrice: 35000.0,
          totalPrice: 35000.0,
          status: "pending",
        ),
        CurrentOrder(
          id: "order_4",
          productId: "prod_4",
          storeId: "store_2",
          quantity: 3,
          selectedColor: "Черный",
          selectedSize: null,
          unitPrice: 150000.0,
          totalPrice: 450000.0,
          status: "pending",
        ),
      ],
    ),
    UserProfile(
      id: "user_2",
      name: "Анна Смирнова",
      emails: ["anna@example.com"],
      phones: ["+998907778899"],
      role: "user",
      avatarUrl: "https://i.pravatar.cc/150?img=2",
    ),
    UserProfile(
      id: "user_3",
      name: "Олег Иванов",
      emails: ["oleg@example.com"],
      phones: ["+998901234567"],
      role: "user",
      avatarUrl: "https://i.pravatar.cc/150?img=3",
    ),
    UserProfile(
      id: "user_4",
      name: "Мария Соколова",
      emails: ["maria@example.com"],
      phones: ["+998908765432"],
      role: "user",
      avatarUrl: "https://i.pravatar.cc/150?img=4",
    ),
    UserProfile(
      id: "user_5",
      name: "Дмитрий Павлов",
      emails: ["dmitry@example.com"],
      phones: ["+998902233445"],
      role: "user",
      avatarUrl: "https://i.pravatar.cc/150?img=5",
    ),
    UserProfile(
      id: "user_6",
      name: "Светлана Ким",
      emails: ["svetlana@example.com"],
      phones: ["+998903334455"],
      role: "user",
      avatarUrl: "https://i.pravatar.cc/150?img=6",
    ),
    UserProfile(
      id: "user_7",
      name: "Алексей Королев",
      emails: ["aleksey@example.com"],
      phones: ["+998904445566"],
      role: "user",
      avatarUrl: "https://i.pravatar.cc/150?img=7",
    ),
  ];
}

class TestSeeder {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ObjectsToAdd objects = ObjectsToAdd();

  Future<void> seedTestData() async {
    final batch = _firestore.batch();

    // ---------- STORES ----------
    for (final store in objects.stores) {
      final ref = _firestore.collection("stores").doc(store.id);
      batch.set(ref, store.toJson());
    }

    // ---------- PRODUCTS ----------
    for (final product in objects.products) {
      final ref = _firestore.collection("products").doc(product.id);
      batch.set(ref, product.toJson());
    }

    // ---------- USERS ----------
    for (final user in objects.users) {
      final ref = _firestore.collection("users").doc(user.id);
      batch.set(ref, user.toJson());
    }

    await batch.commit();
    print("✅ Test data uploaded successfully!");
  }
}
