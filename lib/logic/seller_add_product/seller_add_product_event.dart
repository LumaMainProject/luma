part of 'seller_add_product_bloc.dart';

@immutable
abstract class SellerAddProductEvent {}

/// Инициализация (создание нового или редактирование существующего)
class InitProductForm extends SellerAddProductEvent {
  final Store store;
  final Product? product;
  InitProductForm({required this.store, this.product});
}

/// Обновление текстового поля
class UpdateProductField extends SellerAddProductEvent {
  final String field;
  final String value;
  UpdateProductField(this.field, this.value);
}

/// Загрузка медиа
class SetMainImage extends SellerAddProductEvent {
  final File file;
  SetMainImage(this.file);
}

class AddGalleryImages extends SellerAddProductEvent {
  final List<File> files;
  AddGalleryImages(this.files);
}

class SetVideoFile extends SellerAddProductEvent {
  final File file;
  SetVideoFile(this.file);
}

/// Сохранение
class SaveProduct extends SellerAddProductEvent {}
