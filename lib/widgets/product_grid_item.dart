

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sbbwu_session17_shopping_api/models/product.dart';
import 'package:sbbwu_session17_shopping_api/screens/product_detail_screen.dart';

class ProductGridItem extends StatelessWidget {
  final Product product;
  const ProductGridItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return ProductDetailScreen(product: product);
        }));
      },
      child: Card(
        color: Colors.yellow,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),

                child: CachedNetworkImage(
                  imageUrl: product.image!,
                  width: 150,
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 10,),
              Text( product.title!, maxLines: 1, overflow: TextOverflow.ellipsis,),
              Text( product.category!, maxLines: 1, overflow: TextOverflow.ellipsis,),
              Text( 'Rs. ${product.price!}', maxLines: 1, overflow: TextOverflow.ellipsis,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star),
                  const SizedBox(width: 10,),
                  Text('${product.rating!.rate!}')
                ],)
            ],
          ),
        ),
      ),
    );
  }
}
