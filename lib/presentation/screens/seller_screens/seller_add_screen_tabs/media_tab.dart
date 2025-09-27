import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luma_2/core/theme/app_colors.dart';
import 'package:luma_2/logic/seller_add_product/seller_add_product_bloc.dart';

class MediaTab extends StatefulWidget {
  const MediaTab({super.key});

  @override
  State<MediaTab> createState() => _MediaTabState();
}

class _MediaTabState extends State<MediaTab> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController tagController;

  final List<String> tags = [];

  @override
  void initState() {
    super.initState();
    final state = context.read<SellerAddProductBloc>().state;

    titleController = TextEditingController(text: state.title);
    descriptionController = TextEditingController(text: state.description);
    tagController = TextEditingController();

    titleController.addListener(() {
      if (titleController.text.length <= 80) {
        context.read<SellerAddProductBloc>().add(
          UpdateProductField("title", titleController.text),
        );
      } else {
        titleController.text = titleController.text.substring(0, 80);
        titleController.selection = TextSelection.fromPosition(
          TextPosition(offset: titleController.text.length),
        );
      }
      setState(() {}); // обновляем счётчик
    });

    descriptionController.addListener(() {
      if (descriptionController.text.length <= 2000) {
        context.read<SellerAddProductBloc>().add(
          UpdateProductField("description", descriptionController.text),
        );
      } else {
        descriptionController.text = descriptionController.text.substring(
          0,
          2000,
        );
        descriptionController.selection = TextSelection.fromPosition(
          TextPosition(offset: descriptionController.text.length),
        );
      }
      setState(() {}); // обновляем счётчик
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerAddProductBloc, SellerAddProductState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Название
              const Text(
                "НАЗВАНИЕ ТОВАРА*",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Название (макс. 80 символов)",
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${titleController.text.length}/80",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16),
        
              // Описание
              const Text(
                "Описание",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Опишите товар (макс. 2000 символов)",
                  border: OutlineInputBorder(),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${descriptionController.text.length}/2000",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16),
        
              // Теги
              const Text(
                "ТЕГИ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: tags
                    .map(
                      (tag) => Chip(
                        label: Text(
                          tag,
                          style: const TextStyle(color: AppColors.primary),
                        ),
                        backgroundColor: AppColors.secondary,
                        deleteIcon: const Icon(
                          Icons.close,
                          color: AppColors.primary,
                          size: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: AppColors.secondary,
                            width: 2,
                          ),
                        ),
                        onDeleted: () {
                          setState(() => tags.remove(tag));
                        },
                      ),
                    )
                    .toList(),
              ),
        
              const SizedBox(height: 8),
              TextField(
                controller: tagController,
                decoration: const InputDecoration(
                  hintText: "добавить тег и нажать Enter",
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      tags.add(value);
                      tagController.clear();
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
