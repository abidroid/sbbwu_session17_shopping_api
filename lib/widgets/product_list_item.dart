

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sbbwu_session17_shopping_api/models/product.dart';

import '../screens/product_detail_screen.dart';

class ProductListItem extends StatelessWidget {
  final Product product;
  const ProductListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return ProductDetailScreen(product: product);
        }));
      },
      child: Card(
        color: Colors.lightGreen,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Hero(
                  tag: product.title!,
                  // child: Image.network(product.image!, width: 100, height: 100,

                  child: CachedNetworkImage(imageUrl: product.image!, width: 100, height: 100,
                      fit: BoxFit.fill
                  ),
                ),
              ),

              const SizedBox(width: 10,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.title!, maxLines: 2, overflow: TextOverflow.ellipsis,),
                    Text('Price \$${product.price}'),
                  ],
                ),
              ),
            ],
          ),
        ),),
    );
  }
}
