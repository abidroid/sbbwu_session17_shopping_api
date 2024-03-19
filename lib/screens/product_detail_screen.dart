import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbbwu_session17_shopping_api/models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Hero(
              tag: product.title!,
              child: CachedNetworkImage(imageUrl: product.image!, width: 200, height: 200,)),

          Text(product.title!),
          const Divider(),
          Text(product.description!),
          const Divider(),
          Text('Price: \$${product.price}'),
          const Divider(),
          Text('Rating: ${product.rating!.rate!}'),
          const Divider(),
        ],),
      ),
    );
  }
}
