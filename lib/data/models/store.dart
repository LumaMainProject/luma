import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

double parseDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is int) return value.toDouble();
  if (value is double) return value;
  return 0.0;
}

int parseInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is double) return value.toInt();
  return 0;
}

class Store extends Equatable {
  final String id;
  final String name;
  final String description;
  final String? logoUrl;
  final String? bannerUrl;

  final String ownerId;

  final List<String> emails;
  final List<String> phones;
  final List<StoreAddress> addresses;

  final List<String> productIds;
  final String category;

  final double rating;
  final int reviewsCount;
  final int viewsCount;
  final int favoritesCount;

  /// --- АНАЛИТИКА ---
  final int totalOrders;
  final int totalRevenue;
  final double conversionRate;
  final double averageRating;

  final List<String> socialLinks;
  final List<String> paymentMethods;
  final List<String> deliveryOptions;

  final bool isActive;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  final String? promoType;
  final Timestamp? promoExpiry;

  final List<String> currentOrderIds;
  final List<String> topProductIds;

  final Map<String, int> trafficSources;
  final Map<String, double> conversionFunnel;

  Store({
    required this.id,
    required this.name,
    this.description = '',
    this.logoUrl,
    this.bannerUrl,
    required this.ownerId,
    this.emails = const [],
    this.phones = const [],
    this.addresses = const [],
    this.productIds = const [],
    this.category = '',
    this.rating = 0.0,
    this.reviewsCount = 0,
    this.viewsCount = 0,
    this.favoritesCount = 0,
    this.totalOrders = 0,
    this.totalRevenue = 0,
    this.conversionRate = 0.0,
    this.averageRating = 0.0,
    this.socialLinks = const [],
    this.paymentMethods = const [],
    this.deliveryOptions = const [],
    this.isActive = true,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    this.promoType,
    this.promoExpiry,
    this.currentOrderIds = const [],
    this.topProductIds = const [],
    this.trafficSources = const {},
    this.conversionFunnel = const {},
  }) : createdAt = createdAt ?? Timestamp.now(),
       updatedAt = updatedAt ?? Timestamp.now();

  factory Store.empty() => Store(
    id: '',
    name: '',
    description: '',
    logoUrl: null,
    bannerUrl: null,
    ownerId: '',
    emails: const [],
    phones: const [],
    addresses: const [],
    productIds: const [],
    category: '',
    rating: 0.0,
    reviewsCount: 0,
    viewsCount: 0,
    favoritesCount: 0,
    totalOrders: 0,
    totalRevenue: 0,
    conversionRate: 0.0,
    averageRating: 0.0,
    socialLinks: const [],
    paymentMethods: const [],
    deliveryOptions: const [],
    isActive: false,
    createdAt: Timestamp.now(),
    updatedAt: Timestamp.now(),
    promoType: null,
    promoExpiry: null,
    currentOrderIds: const [],
    topProductIds: const [],
    trafficSources: const {},
    conversionFunnel: const {},
  );

  factory Store.fromJson(Map<String, dynamic> json, String id) {
    return Store(
      id: id,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      logoUrl: json['logoUrl'],
      bannerUrl: json['bannerUrl'],
      ownerId: json['ownerId'] ?? '',
      emails: List<String>.from(json['emails'] ?? const []),
      phones: List<String>.from(json['phones'] ?? const []),
      addresses: (json['addresses'] as List<dynamic>? ?? const [])
          .map((a) => StoreAddress.fromJson(a))
          .toList(),
      productIds: List<String>.from(json['productIds'] ?? const []),
      category: json['category'] ?? '',
      rating: parseDouble(json['rating']),
      reviewsCount: parseInt(json['reviewsCount']),
      viewsCount: parseInt(json['viewsCount']),
      favoritesCount: parseInt(json['favoritesCount']),
      totalOrders: parseInt(json['totalOrders']),
      totalRevenue: parseInt(json['totalRevenue']),
      conversionRate: parseDouble(json['conversionRate']),
      averageRating: parseDouble(json['averageRating']),
      socialLinks: List<String>.from(json['socialLinks'] ?? const []),
      paymentMethods: List<String>.from(json['paymentMethods'] ?? const []),
      deliveryOptions: List<String>.from(json['deliveryOptions'] ?? const []),
      isActive: json['isActive'] ?? true,
      createdAt: json['createdAt'] ?? Timestamp.now(),
      updatedAt: json['updatedAt'] ?? Timestamp.now(),
      promoType: json['promoType'],
      promoExpiry: json['promoExpiry'],
      currentOrderIds: List<String>.from(json['currentOrderIds'] ?? const []),
      topProductIds: List<String>.from(json['topProductIds'] ?? const []),
      trafficSources: Map<String, int>.from(json['trafficSources'] ?? const {}),
      conversionFunnel: Map<String, double>.from(
        (json['conversionFunnel'] ?? {}).map(
          (key, value) => MapEntry(key, parseDouble(value)),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "logoUrl": logoUrl,
    "bannerUrl": bannerUrl,
    "ownerId": ownerId,
    "emails": emails,
    "phones": phones,
    "addresses": addresses.map((a) => a.toJson()).toList(),
    "productIds": productIds,
    "category": category,
    "rating": rating,
    "reviewsCount": reviewsCount,
    "viewsCount": viewsCount,
    "favoritesCount": favoritesCount,
    "totalOrders": totalOrders,
    "totalRevenue": totalRevenue,
    "conversionRate": conversionRate,
    "averageRating": averageRating,
    "socialLinks": socialLinks,
    "paymentMethods": paymentMethods,
    "deliveryOptions": deliveryOptions,
    "isActive": isActive,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "promoType": promoType,
    "promoExpiry": promoExpiry,
    "currentOrderIds": currentOrderIds,
    "topProductIds": topProductIds,
    "trafficSources": trafficSources,
    "conversionFunnel": conversionFunnel,
  };

  Store copyWith({
    String? id,
    String? name,
    String? description,
    String? logoUrl,
    String? bannerUrl,
    String? ownerId,
    List<String>? emails,
    List<String>? phones,
    List<StoreAddress>? addresses,
    List<String>? productIds,
    String? category,
    double? rating,
    int? reviewsCount,
    int? viewsCount,
    int? favoritesCount,
    int? totalOrders,
    int? totalRevenue,
    double? conversionRate,
    double? averageRating,
    List<String>? socialLinks,
    List<String>? paymentMethods,
    List<String>? deliveryOptions,
    bool? isActive,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    String? promoType,
    Timestamp? promoExpiry,
    List<String>? currentOrderIds,
    List<String>? topProductIds,
    Map<String, int>? trafficSources,
    Map<String, double>? conversionFunnel,
  }) {
    return Store(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      logoUrl: logoUrl ?? this.logoUrl,
      bannerUrl: bannerUrl ?? this.bannerUrl,
      ownerId: ownerId ?? this.ownerId,
      emails: emails ?? this.emails,
      phones: phones ?? this.phones,
      addresses: addresses ?? this.addresses,
      productIds: productIds ?? this.productIds,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      viewsCount: viewsCount ?? this.viewsCount,
      favoritesCount: favoritesCount ?? this.favoritesCount,
      totalOrders: totalOrders ?? this.totalOrders,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      conversionRate: conversionRate ?? this.conversionRate,
      averageRating: averageRating ?? this.averageRating,
      socialLinks: socialLinks ?? this.socialLinks,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      deliveryOptions: deliveryOptions ?? this.deliveryOptions,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      promoType: promoType ?? this.promoType,
      promoExpiry: promoExpiry ?? this.promoExpiry,
      currentOrderIds: currentOrderIds ?? this.currentOrderIds,
      topProductIds: topProductIds ?? this.topProductIds,
      trafficSources: trafficSources ?? this.trafficSources,
      conversionFunnel: conversionFunnel ?? this.conversionFunnel,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    logoUrl,
    bannerUrl,
    ownerId,
    emails,
    phones,
    addresses,
    productIds,
    category,
    rating,
    reviewsCount,
    viewsCount,
    favoritesCount,
    totalOrders,
    totalRevenue,
    conversionRate,
    averageRating,
    socialLinks,
    paymentMethods,
    deliveryOptions,
    isActive,
    createdAt,
    updatedAt,
    promoType,
    promoExpiry,
    currentOrderIds,
    topProductIds,
    trafficSources,
    conversionFunnel,
  ];
}

class StoreAddress extends Equatable {
  final String label;
  final String country;
  final String city;
  final String street;
  final String postalCode;
  final bool isDefault;

  const StoreAddress({
    required this.label,
    required this.country,
    required this.city,
    required this.street,
    required this.postalCode,
    this.isDefault = false,
  });

  factory StoreAddress.fromJson(Map<String, dynamic> json) => StoreAddress(
    label: json['label'] ?? '',
    country: json['country'] ?? '',
    city: json['city'] ?? '',
    street: json['street'] ?? '',
    postalCode: json['postalCode'] ?? '',
    isDefault: json['isDefault'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "country": country,
    "city": city,
    "street": street,
    "postalCode": postalCode,
    "isDefault": isDefault,
  };

  @override
  List<Object?> get props => [
    label,
    country,
    city,
    street,
    postalCode,
    isDefault,
  ];
}
