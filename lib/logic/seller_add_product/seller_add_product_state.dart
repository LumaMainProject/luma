part of 'seller_add_product_bloc.dart';

@immutable
class SellerAddProductState {
  final Store? store;
  final Product? product;
  final bool isEdit;
  final bool isLoading;
  final String? error;
  final bool success;

  // поля
  final String title;
  final String description;
  final String price;
  final String category;
  final String brand;
  final String country;
  final String material;
  final String warranty;
  final String returnPolicy;

  // списки
  final List<String> colors;
  final List<String> sizes;
  final List<String> tags;
  final List<String> deliveryOptions;
  final List<String> searchKeywords;
  final Map<String, String> specs;

  // медиа (локальные и загруженные)
  final File? mainImage;
  final List<File> gallery;
  final File? video;

  final String? mainImageUrl;
  final List<String> galleryUrls;
  final String? videoUrl;

  const SellerAddProductState({
    this.store,
    this.product,
    this.isEdit = false,
    this.isLoading = false,
    this.error,
    this.success = false,
    this.title = "",
    this.description = "",
    this.price = "",
    this.category = "",
    this.brand = "",
    this.country = "",
    this.material = "",
    this.warranty = "",
    this.returnPolicy = "",
    this.colors = const [],
    this.sizes = const [],
    this.tags = const [],
    this.deliveryOptions = const [],
    this.searchKeywords = const [],
    this.specs = const {},
    this.mainImage,
    this.gallery = const [],
    this.video,
    this.mainImageUrl,
    this.galleryUrls = const [],
    this.videoUrl,
  });

  SellerAddProductState copyWith({
    Store? store,
    Product? product,
    bool? isEdit,
    bool? isLoading,
    String? error,
    bool? success,
    String? title,
    String? description,
    String? price,
    String? category,
    String? brand,
    String? country,
    String? material,
    String? warranty,
    String? returnPolicy,
    List<String>? colors,
    List<String>? sizes,
    List<String>? tags,
    List<String>? deliveryOptions,
    List<String>? searchKeywords,
    Map<String, String>? specs,
    File? mainImage,
    List<File>? gallery,
    File? video,
    String? mainImageUrl,
    List<String>? galleryUrls,
    String? videoUrl,
  }) {
    return SellerAddProductState(
      store: store ?? this.store,
      product: product ?? this.product,
      isEdit: isEdit ?? this.isEdit,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      success: success ?? this.success,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      country: country ?? this.country,
      material: material ?? this.material,
      warranty: warranty ?? this.warranty,
      returnPolicy: returnPolicy ?? this.returnPolicy,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
      tags: tags ?? this.tags,
      deliveryOptions: deliveryOptions ?? this.deliveryOptions,
      searchKeywords: searchKeywords ?? this.searchKeywords,
      specs: specs ?? this.specs,
      mainImage: mainImage ?? this.mainImage,
      gallery: gallery ?? this.gallery,
      video: video ?? this.video,
      mainImageUrl: mainImageUrl ?? this.mainImageUrl,
      galleryUrls: galleryUrls ?? this.galleryUrls,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }
}
