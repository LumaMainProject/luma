import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:luma_2/data/models/review.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String name;
  final String description;
  final String article;
  final String category;
  final String type;
  final String brand;
  final String countryOfOrigin;
  final double price;
  final double? discountPrice;
  final bool isPromo;
  final String imageUrl;
  final List<String> images;
  final String? videoUrl;
  final List<String>? gallery360;
  final List<String> colors;
  final String material;
  final List<String> sizes;
  final List<String> tags;
  final List<String> searchKeywords;
  final String sellerId;
  final int ordersCount;
  final int favoritesCount;
  final int viewsCount;
  final double rating;
  final int ratingCount;
  final int reviewsCount;
  final double popularityScore;
  final int stock;
  final String status;
  final List<String> deliveryOptions;
  final String? returnPolicy;
  final String? warranty;
  final bool isDeleted;
  final String? updatedBy;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final Timestamp? lastReviewAt;

  /// --- НОВЫЕ ПОЛЯ ---
  final Map<String, String>? specs; // характеристики товара
  final List<Review>? reviews; // список отзывов

  Product({
    required this.id,
    required this.title,
    required this.name,
    required this.description,
    required this.article,
    required this.category,
    required this.type,
    required this.brand,
    required this.countryOfOrigin,
    required this.price,
    this.discountPrice,
    this.isPromo = false,
    required this.imageUrl,
    this.images = const [],
    this.videoUrl,
    this.gallery360,
    this.colors = const [],
    this.material = "",
    this.sizes = const [],
    this.tags = const [],
    this.searchKeywords = const [],
    required this.sellerId,
    this.ordersCount = 0,
    this.favoritesCount = 0,
    this.viewsCount = 0,
    this.rating = 0.0,
    this.ratingCount = 0,
    this.reviewsCount = 0,
    this.popularityScore = 0.0,
    this.stock = 0,
    this.status = "active",
    this.deliveryOptions = const [],
    this.returnPolicy,
    this.warranty,
    this.isDeleted = false,
    this.updatedBy,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    this.lastReviewAt,
    this.specs,
    this.reviews,
  }) : createdAt = createdAt ?? Timestamp.now(),
       updatedAt = updatedAt ?? Timestamp.now();

  factory Product.fromJson(Map<String, dynamic> json, String id) {
    return Product(
      id: id,
      title: json['title'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      article: json['article'] ?? '',
      category: json['category'] ?? '',
      type: json['type'] ?? '',
      brand: json['brand'] ?? '',
      countryOfOrigin: json['countryOfOrigin'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discountPrice: (json['discountPrice'] != null)
          ? (json['discountPrice'] as num).toDouble()
          : null,
      isPromo: json['isPromo'] ?? false,
      imageUrl: json['imageUrl'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      videoUrl: json['videoUrl'],
      gallery360: (json['gallery360'] != null)
          ? List<String>.from(json['gallery360'])
          : null,
      colors: List<String>.from(json['colors'] ?? []),
      material: json['material'] ?? '',
      sizes: List<String>.from(json['sizes'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      searchKeywords: List<String>.from(json['searchKeywords'] ?? []),
      sellerId: json['sellerId'] ?? '',
      ordersCount: json['ordersCount'] ?? 0,
      favoritesCount: json['favoritesCount'] ?? 0,
      viewsCount: json['viewsCount'] ?? 0,
      rating: (json['rating'] ?? 0.0).toDouble(),
      ratingCount: json['ratingCount'] ?? 0,
      reviewsCount: json['reviewsCount'] ?? 0,
      popularityScore: (json['popularityScore'] ?? 0.0).toDouble(),
      stock: json['stock'] ?? 0,
      status: json['status'] ?? "active",
      deliveryOptions: List<String>.from(json['deliveryOptions'] ?? []),
      returnPolicy: json['returnPolicy'],
      warranty: json['warranty'],
      isDeleted: json['isDeleted'] ?? false,
      updatedBy: json['updatedBy'],
      createdAt: json['createdAt'] ?? Timestamp.now(),
      updatedAt: json['updatedAt'] ?? Timestamp.now(),
      lastReviewAt: json['lastReviewAt'],

      /// --- NEW ---
      specs: (json['specs'] != null)
          ? Map<String, String>.from(json['specs'])
          : null,
      reviews: (json['reviews'] != null)
          ? (json['reviews'] as List).map((e) => Review.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "name": name,
      "description": description,
      "article": article,
      "category": category,
      "type": type,
      "brand": brand,
      "countryOfOrigin": countryOfOrigin,
      "price": price,
      "discountPrice": discountPrice,
      "isPromo": isPromo,
      "imageUrl": imageUrl,
      "images": images,
      "videoUrl": videoUrl,
      "gallery360": gallery360,
      "colors": colors,
      "material": material,
      "sizes": sizes,
      "tags": tags,
      "searchKeywords": searchKeywords,
      "sellerId": sellerId,
      "ordersCount": ordersCount,
      "favoritesCount": favoritesCount,
      "viewsCount": viewsCount,
      "rating": rating,
      "ratingCount": ratingCount,
      "reviewsCount": reviewsCount,
      "popularityScore": popularityScore,
      "stock": stock,
      "status": status,
      "deliveryOptions": deliveryOptions,
      "returnPolicy": returnPolicy,
      "warranty": warranty,
      "isDeleted": isDeleted,
      "updatedBy": updatedBy,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "lastReviewAt": lastReviewAt,

      /// --- NEW ---
      "specs": specs,
      "reviews": reviews?.map((e) => e.toJson()).toList(),
    };
  }

  Product copyWith({
    String? id,
    String? title,
    String? name,
    String? description,
    String? article,
    String? category,
    String? type,
    String? brand,
    String? countryOfOrigin,
    double? price,
    double? discountPrice,
    bool? isPromo,
    String? imageUrl,
    List<String>? images,
    String? videoUrl,
    List<String>? gallery360,
    List<String>? colors,
    String? material,
    List<String>? sizes,
    List<String>? tags,
    List<String>? searchKeywords,
    String? sellerId,
    int? ordersCount,
    int? favoritesCount,
    int? viewsCount,
    double? rating,
    int? ratingCount,
    int? reviewsCount,
    double? popularityScore,
    int? stock,
    String? status,
    List<String>? deliveryOptions,
    String? returnPolicy,
    String? warranty,
    bool? isDeleted,
    String? updatedBy,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    Timestamp? lastReviewAt,
    Map<String, String>? specs,
    List<Review>? reviews,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      name: name ?? this.name,
      description: description ?? this.description,
      article: article ?? this.article,
      category: category ?? this.category,
      type: type ?? this.type,
      brand: brand ?? this.brand,
      countryOfOrigin: countryOfOrigin ?? this.countryOfOrigin,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      isPromo: isPromo ?? this.isPromo,
      imageUrl: imageUrl ?? this.imageUrl,
      images: images ?? this.images,
      videoUrl: videoUrl ?? this.videoUrl,
      gallery360: gallery360 ?? this.gallery360,
      colors: colors ?? this.colors,
      material: material ?? this.material,
      sizes: sizes ?? this.sizes,
      tags: tags ?? this.tags,
      searchKeywords: searchKeywords ?? this.searchKeywords,
      sellerId: sellerId ?? this.sellerId,
      ordersCount: ordersCount ?? this.ordersCount,
      favoritesCount: favoritesCount ?? this.favoritesCount,
      viewsCount: viewsCount ?? this.viewsCount,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      popularityScore: popularityScore ?? this.popularityScore,
      stock: stock ?? this.stock,
      status: status ?? this.status,
      deliveryOptions: deliveryOptions ?? this.deliveryOptions,
      returnPolicy: returnPolicy ?? this.returnPolicy,
      warranty: warranty ?? this.warranty,
      isDeleted: isDeleted ?? this.isDeleted,
      updatedBy: updatedBy ?? this.updatedBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastReviewAt: lastReviewAt ?? this.lastReviewAt,
      specs: specs ?? this.specs,
      reviews: reviews ?? this.reviews,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    name,
    description,
    article,
    category,
    type,
    brand,
    countryOfOrigin,
    price,
    discountPrice,
    isPromo,
    imageUrl,
    images,
    videoUrl,
    gallery360,
    colors,
    material,
    sizes,
    tags,
    searchKeywords,
    sellerId,
    ordersCount,
    favoritesCount,
    viewsCount,
    rating,
    ratingCount,
    reviewsCount,
    popularityScore,
    stock,
    status,
    deliveryOptions,
    returnPolicy,
    warranty,
    isDeleted,
    updatedBy,
    createdAt,
    updatedAt,
    lastReviewAt,
    specs,
    reviews,
  ];
}


