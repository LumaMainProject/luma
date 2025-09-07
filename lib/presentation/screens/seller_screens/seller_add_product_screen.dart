import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luma_2/data/models/product.dart';
import 'package:luma_2/data/models/store.dart';
import 'package:luma_2/logic/seller_add_product/seller_add_product_bloc.dart';

class SellerAddProductScreen extends StatefulWidget {
  final Store store;
  final Product? product;

  const SellerAddProductScreen({super.key, required this.store, this.product});

  @override
  State<SellerAddProductScreen> createState() => _SellerAddProductScreenState();
}

class _SellerAddProductScreenState extends State<SellerAddProductScreen> {
  late final TextEditingController titleController;
  late final TextEditingController priceController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();

    final state = context.read<SellerAddProductBloc>().state;

    titleController = TextEditingController(text: state.title);
    priceController = TextEditingController(text: state.price);
    descriptionController = TextEditingController(text: state.description);

    // слушатели → диспатчим изменения в блок
    titleController.addListener(() {
      context.read<SellerAddProductBloc>().add(
        UpdateProductField("title", titleController.text),
      );
    });

    priceController.addListener(() {
      context.read<SellerAddProductBloc>().add(
        UpdateProductField("price", priceController.text),
      );
    });

    descriptionController.addListener(() {
      context.read<SellerAddProductBloc>().add(
        UpdateProductField("description", descriptionController.text),
      );
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SellerAddProductBloc, SellerAddProductState>(
      listenWhen: (previous, current) =>
          previous.success != current.success ||
          previous.error != current.error,
      listener: (context, state) {
        if (state.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Товар успешно сохранён")),
          );
          Navigator.pop(context);
        }

        if (state.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Ошибка: ${state.error}")));
        }
      },
      builder: (context, state) {
        final bloc = context.read<SellerAddProductBloc>();

        return Scaffold(
          appBar: AppBar(
            title: Text(
              state.isEdit ? "Редактировать товар" : "Добавить товар",
            ),
            actions: [
              IconButton(
                onPressed: () => bloc.add(SaveProduct()),
                icon: const Icon(Icons.save),
              ),
            ],
          ),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Название
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          labelText: "Название",
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Цена
                      TextField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Цена"),
                      ),
                      const SizedBox(height: 12),

                      // Описание
                      TextField(
                        controller: descriptionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: "Описание",
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Главная картинка
                      Row(
                        children: [
                          if (state.mainImage != null)
                            Image.file(
                              state.mainImage!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          if (state.mainImage == null &&
                              state.mainImageUrl != null)
                            Image.network(
                              state.mainImageUrl!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          IconButton(
                            icon: const Icon(Icons.add_a_photo),
                            onPressed: () async {
                              final picker = ImagePicker();
                              final file = await picker.pickImage(
                                source: ImageSource.gallery,
                              );
                              if (file != null) {
                                bloc.add(SetMainImage(File(file.path)));
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Галерея
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Галерея:"),
                          Wrap(
                            spacing: 8,
                            children: [
                              ...state.gallery.map(
                                (f) => Image.file(
                                  f,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              ...state.galleryUrls.map(
                                (url) => Image.network(
                                  url,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.photo_library),
                                onPressed: () async {
                                  final picker = ImagePicker();
                                  final files = await picker.pickMultiImage();
                                  if (files.isNotEmpty) {
                                    bloc.add(
                                      AddGalleryImages(
                                        files.map((f) => File(f.path)).toList(),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Видео
                      Row(
                        children: [
                          if (state.video != null)
                            const Icon(Icons.videocam, size: 40),
                          if (state.video == null && state.videoUrl != null)
                            const Icon(Icons.play_circle_fill, size: 40),
                          IconButton(
                            icon: const Icon(Icons.video_call),
                            onPressed: () async {
                              final picker = ImagePicker();
                              final file = await picker.pickVideo(
                                source: ImageSource.gallery,
                              );
                              if (file != null) {
                                bloc.add(SetVideoFile(File(file.path)));
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
