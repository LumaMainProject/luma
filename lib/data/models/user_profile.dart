import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:luma_2/data/models/enum_gender.dart';

// ---------------- USER PROFILE ----------------
class UserProfile extends Equatable {
  final String id;
  final String name;
  final List<String> emails;
  final List<String> phones;
  final String? avatarUrl;
  final Gender gender;
  final DateTime? birthDate;

  final List<String> favoriteProducts;
  final List<String> favoriteStores;

  final List<String> orderHistory;
  final List<CurrentOrder> currentOrders; // корзина
  final List<CurrentOrder> inTrackOrders; // заказы в процессе

  final List<UserAddress> addresses;
  final List<PaymentMethod> paymentMethods;

  final String role;
  final bool notificationsEnabled;
  final String language;
  final String currency;

  final Timestamp createdAt;
  final Timestamp updatedAt;

  UserProfile({
    required this.id,
    required this.name,
    this.gender = Gender.unknown,
    this.birthDate,
    this.emails = const [],
    this.phones = const [],
    this.avatarUrl,
    this.favoriteProducts = const [],
    this.favoriteStores = const [],
    this.orderHistory = const [],
    this.currentOrders = const [],
    this.inTrackOrders = const [],
    this.addresses = const [],
    this.paymentMethods = const [],
    this.role = "user",
    this.notificationsEnabled = true,
    this.language = "ru",
    this.currency = "UZS",
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) : createdAt = createdAt ?? Timestamp.now(),
       updatedAt = updatedAt ?? Timestamp.now();

  UserProfile copyWith({
    String? id,
    String? name,
    List<String>? emails,
    Gender? gender,
    DateTime? birthDate,
    List<String>? phones,
    String? avatarUrl,
    List<String>? favoriteProducts,
    List<String>? favoriteStores,
    List<String>? orderHistory,
    List<CurrentOrder>? currentOrders,
    List<CurrentOrder>? inTrackOrders,
    List<UserAddress>? addresses,
    List<PaymentMethod>? paymentMethods,
    String? role,
    bool? notificationsEnabled,
    String? language,
    String? currency,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      emails: emails ?? this.emails,
      phones: phones ?? this.phones,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      favoriteStores: favoriteStores ?? this.favoriteStores,
      orderHistory: orderHistory ?? this.orderHistory,
      currentOrders: currentOrders ?? this.currentOrders,
      inTrackOrders: inTrackOrders ?? this.inTrackOrders,
      addresses: addresses ?? this.addresses,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      role: role ?? this.role,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      language: language ?? this.language,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json, String id) {
    return UserProfile(
      id: id,
      name: json['name'] ?? '',
      emails: List<String>.from(json['emails'] ?? []),
      phones: List<String>.from(json['phones'] ?? []),
      avatarUrl: json['avatarUrl'],
      gender: (json['gender'] != null)
          ? Gender.values.firstWhere(
              (e) => e.toString() == 'Gender.${json['gender']}',
              orElse: () => Gender.unknown,
            )
          : Gender.unknown,
      birthDate: json['birthDate'] != null
          ? (json['birthDate'] as Timestamp).toDate()
          : null,
      favoriteProducts: List<String>.from(json['favoriteProducts'] ?? []),
      favoriteStores: List<String>.from(json['favoriteStores'] ?? []),
      orderHistory: List<String>.from(json['orderHistory'] ?? []),
      currentOrders: (json['currentOrders'] as List<dynamic>? ?? [])
          .map((o) => CurrentOrder.fromJson(o))
          .toList(),
      inTrackOrders: (json['inTrackOrders'] as List<dynamic>? ?? [])
          .map((o) => CurrentOrder.fromJson(o))
          .toList(),
      addresses: (json['addresses'] as List<dynamic>? ?? [])
          .map((a) => UserAddress.fromJson(a))
          .toList(),
      paymentMethods: (json['paymentMethods'] as List<dynamic>? ?? [])
          .map((p) => PaymentMethod.fromJson(p))
          .toList(),
      role: json['role'] ?? 'user',
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      language: json['language'] ?? "ru",
      currency: json['currency'] ?? "UZS",
      createdAt: json['createdAt'] ?? Timestamp.now(),
      updatedAt: json['updatedAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "emails": emails,
      "phones": phones,
      "avatarUrl": avatarUrl,
      "gender": gender.toString().split('.').last,
      "birthDate": birthDate != null ? Timestamp.fromDate(birthDate!) : null,
      "favoriteProducts": favoriteProducts,
      "favoriteStores": favoriteStores,
      "orderHistory": orderHistory,
      "currentOrders": currentOrders.map((o) => o.toJson()).toList(),
      "inTrackOrders": inTrackOrders.map((o) => o.toJson()).toList(),
      "addresses": addresses.map((a) => a.toJson()).toList(),
      "paymentMethods": paymentMethods.map((p) => p.toJson()).toList(),
      "role": role,
      "notificationsEnabled": notificationsEnabled,
      "language": language,
      "currency": currency,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    emails,
    phones,
    avatarUrl,
    gender,
    birthDate,
    favoriteProducts,
    favoriteStores,
    orderHistory,
    currentOrders,
    inTrackOrders,
    addresses,
    paymentMethods,
    role,
    notificationsEnabled,
    language,
    currency,
    createdAt,
    updatedAt,
  ];
}

// ---------------- CURRENT ORDER ----------------
class CurrentOrder extends Equatable {
  final String id; // UID заказа
  final String productId;
  final String storeId;
  final int quantity;
  final String? selectedColor;
  final String? selectedSize;
  final double unitPrice;
  final double totalPrice;
  final String status; // pending, paid, delivered
  final Timestamp createdAt;
  final Timestamp updatedAt;

  CurrentOrder({
    required this.id,
    required this.productId,
    required this.storeId,
    this.quantity = 1,
    this.selectedColor,
    this.selectedSize,
    required this.unitPrice,
    required this.totalPrice,
    this.status = "pending",
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) : createdAt = createdAt ?? Timestamp.now(),
       updatedAt = updatedAt ?? Timestamp.now();

  factory CurrentOrder.fromJson(Map<String, dynamic> json) {
    return CurrentOrder(
      id: json['id'] ?? '',
      productId: json['productId'] ?? '',
      storeId: json['storeId'] ?? '',
      quantity: json['quantity'] ?? 1,
      selectedColor: json['selectedColor'],
      selectedSize: json['selectedSize'],
      unitPrice: (json['unitPrice'] ?? 0).toDouble(),
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      status: json['status'] ?? "pending",
      createdAt: json['createdAt'] ?? Timestamp.now(),
      updatedAt: json['updatedAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "productId": productId,
      "storeId": storeId,
      "quantity": quantity,
      "selectedColor": selectedColor,
      "selectedSize": selectedSize,
      "unitPrice": unitPrice,
      "totalPrice": totalPrice,
      "status": status,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }

  CurrentOrder copyWith({
    String? id,
    String? productId,
    String? storeId,
    int? quantity,
    String? selectedColor,
    String? selectedSize,
    double? unitPrice,
    double? totalPrice,
    String? status,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return CurrentOrder(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      storeId: storeId ?? this.storeId,
      quantity: quantity ?? this.quantity,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedSize: selectedSize ?? this.selectedSize,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    productId,
    storeId,
    quantity,
    selectedColor,
    selectedSize,
    unitPrice,
    totalPrice,
    status,
    createdAt,
    updatedAt,
  ];
}

// ---------------- ADDRESS ----------------
class UserAddress extends Equatable {
  final String label;
  final String country;
  final String city;
  final String street;
  final String postalCode;
  final bool isDefault;

  const UserAddress({
    required this.label,
    required this.country,
    required this.city,
    required this.street,
    required this.postalCode,
    this.isDefault = false,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      label: json['label'] ?? '',
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      street: json['street'] ?? '',
      postalCode: json['postalCode'] ?? '',
      isDefault: json['isDefault'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "label": label,
      "country": country,
      "city": city,
      "street": street,
      "postalCode": postalCode,
      "isDefault": isDefault,
    };
  }

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

// ---------------- PAYMENT METHOD ----------------
class PaymentMethod extends Equatable {
  final String type; // card, paypal, etc
  final String last4;
  final String brand;
  final int expMonth;
  final int expYear;
  final bool isDefault;

  const PaymentMethod({
    required this.type,
    required this.last4,
    required this.brand,
    required this.expMonth,
    required this.expYear,
    this.isDefault = false,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      type: json['type'] ?? 'card',
      last4: json['last4'] ?? '',
      brand: json['brand'] ?? '',
      expMonth: json['expMonth'] ?? 1,
      expYear: json['expYear'] ?? 2000,
      isDefault: json['isDefault'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "last4": last4,
      "brand": brand,
      "expMonth": expMonth,
      "expYear": expYear,
      "isDefault": isDefault,
    };
  }

  @override
  List<Object?> get props => [type, last4, brand, expMonth, expYear, isDefault];
}
