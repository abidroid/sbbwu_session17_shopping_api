import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sbbwu_session17_shopping_api/models/product.dart';
import 'package:sbbwu_session17_shopping_api/screens/product_detail_screen.dart';
import 'package:sbbwu_session17_shopping_api/widgets/product_grid_item.dart';

class ProductGridWidget extends StatelessWidget {
  final List<Product> products;

  const ProductGridWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10,
        mainAxisExtent: 300,
        ),
        itemBuilder: (context, index) {

          Product product = products[index];

          return ProductGridItem(product: product);
        });
  }
}
