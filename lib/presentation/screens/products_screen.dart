import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/models/product.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("products").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

        final products = snapshot.data!.docs.map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>, doc.id)).toList();

        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, i) {
            final p = products[i];
            return ListTile(
              leading: p.imageUrl.isNotEmpty ? Image.network(p.imageUrl, width: 50, height: 50) : null,
              title: Text(p.title),
              subtitle: Text("\$${p.price}"),
            );
          },
        );
      },
    );
  }
}
