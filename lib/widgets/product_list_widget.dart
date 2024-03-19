

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sbbwu_session17_shopping_api/models/product.dart';
import 'package:sbbwu_session17_shopping_api/screens/product_detail_screen.dart';
import 'package:sbbwu_session17_shopping_api/widgets/product_list_item.dart';

class ProductListWidget extends StatelessWidget {

  final List<Product> products;
  const ProductListWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index){

          Product product = products[index];

          return ProductListItem(product: product);
        });
  }
}
