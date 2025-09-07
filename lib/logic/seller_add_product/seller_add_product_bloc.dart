import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/data/models/product.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/data/repositories/products_repository.dart';

part 'seller_add_product_event.dart';
part 'seller_add_product_state.dart';

class SellerAddProductBloc
    extends Bloc<SellerAddProductEvent, SellerAddProductState> {
  final ProductsRepository repository;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  SellerAddProductBloc(this.repository) : super(const SellerAddProductState()) {
    on<InitProductForm>(_onInitForm);
    on<UpdateProductField>(_onUpdateField);
    on<SetMainImage>((e, emit) => emit(state.copyWith(mainImage: e.file)));
    on<AddGalleryImages>(
      (e, emit) =>
          emit(state.copyWith(gallery: [...state.gallery, ...e.files])),
    );
    on<SetVideoFile>((e, emit) => emit(state.copyWith(video: e.file)));
    on<SaveProduct>(_onSaveProduct);
  }

  void _onInitForm(InitProductForm event, Emitter emit) {
    final product = event.product;
    emit(
      state.copyWith(
        store: event.store,
        product: product,
        isEdit: product != null,
        title: product?.title ?? "",
        description: product?.description ?? "",
        price: product?.price.toString() ?? "",
        category: product?.category ?? "",
        brand: product?.brand ?? "",
        country: product?.countryOfOrigin ?? "",
        material: product?.material ?? "",
        warranty: product?.warranty ?? "",
        returnPolicy: product?.returnPolicy ?? "",
        colors: product?.colors ?? [],
        sizes: product?.sizes ?? [],
        tags: product?.tags ?? [],
        deliveryOptions: product?.deliveryOptions ?? [],
        searchKeywords: product?.searchKeywords ?? [],
        specs: product?.specs ?? {},
        mainImageUrl: product?.imageUrl,
        galleryUrls: product?.images ?? [],
        videoUrl: product?.videoUrl,
      ),
    );
  }

  void _onUpdateField(UpdateProductField event, Emitter emit) {
    switch (event.field) {
      case "title":
        emit(state.copyWith(title: event.value, success: false, error: null));
        break;
      case "price":
        emit(state.copyWith(price: event.value, success: false, error: null));
        break;
      case "description":
        emit(state.copyWith(description: event.value, success: false, error: null));
        break;
      case "category":
        emit(state.copyWith(category: event.value, success: false, error: null));
        break;
      case "brand":
        emit(state.copyWith(brand: event.value, success: false, error: null));
        break;
      case "country":
        emit(state.copyWith(country: event.value, success: false, error: null));
        break;
      case "material":
        emit(state.copyWith(material: event.value, success: false, error: null));
        break;
      case "warranty":
        emit(state.copyWith(warranty: event.value, success: false, error: null));
        break;
      case "returnPolicy":
        emit(state.copyWith(returnPolicy: event.value, success: false, error: null));
        break;
    }
  }

  Future<void> _onSaveProduct(
    SaveProduct event,
    Emitter<SellerAddProductState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, success: false));

    try {
      final store = state.store!;
      final product = state.product ?? Product.empty();

      final isEdit = product.id.isNotEmpty;
      final docRef = isEdit
          ? firestore.collection("products").doc(product.id)
          : firestore.collection("products").doc();

      // загрузка файлов
      final imageUrl = state.mainImage != null
          ? await _uploadFile(
              state.mainImage!,
              "products/${docRef.id}/main.jpg",
            )
          : state.mainImageUrl ?? "";

      final galleryUrls = [
        ...state.galleryUrls,
        if (state.gallery.isNotEmpty)
          ...(await Future.wait(
            state.gallery.asMap().entries.map(
              (e) => _uploadFile(
                e.value,
                "products/${docRef.id}/gallery_${DateTime.now().millisecondsSinceEpoch}_${e.key}.jpg",
              ),
            ),
          )).whereType<String>(),
      ];

      final videoUrl = state.video != null
          ? await _uploadFile(state.video!, "products/${docRef.id}/video.mp4")
          : state.videoUrl;

      final newProduct = product.copyWith(
        id: docRef.id,
        title: state.title,
        description: state.description,
        price: double.tryParse(state.price) ?? 0,
        category: state.category,
        brand: state.brand,
        countryOfOrigin: state.country,
        material: state.material,
        warranty: state.warranty,
        returnPolicy: state.returnPolicy,
        colors: state.colors,
        sizes: state.sizes,
        tags: state.tags,
        deliveryOptions: state.deliveryOptions,
        searchKeywords: state.searchKeywords,
        specs: state.specs,
        imageUrl: imageUrl,
        images: galleryUrls,
        videoUrl: videoUrl,
        updatedAt: Timestamp.now(),
        createdAt: product.createdAt ?? Timestamp.now(),
      );

      await docRef.set(newProduct.toJson());

      if (!isEdit) {
        await firestore.collection("stores").doc(store.id).update({
          "productIds": FieldValue.arrayUnion([docRef.id]),
        });
      }

      emit(
        state.copyWith(isLoading: false, success: true, product: newProduct),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<String?> _uploadFile(File file, String path) async {
    try {
      final ref = storage.ref().child(path);
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (e) {
      debugPrint("Ошибка загрузки файла: $e");
      return null;
    }
  }
}
