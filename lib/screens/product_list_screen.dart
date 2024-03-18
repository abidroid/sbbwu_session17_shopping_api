
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbbwu_session17_shopping_api/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:sbbwu_session17_shopping_api/screens/product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  Future<List<Product>> getAllProducts() async {
    List<Product> productList = [];


    http.Response response = await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if( response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);

      for( var jsonProduct in jsonResponse){

        Product product = Product.fromJson(jsonProduct);

        productList.add(product);
      }

      return productList;

    }else{
      throw Exception('Something Went Wrong');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: FutureBuilder<List<Product>>(
        future: getAllProducts(),
        builder: (context, snapshot){

          if( snapshot.hasData){

            List<Product> products = snapshot.data!;

            return  ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index){

                  Product product = products[index];

                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return ProductDetailScreen(product: product);
                      }));
                    },
                    child: Card(
                      color: Colors.amber,
                      child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Hero(
                              tag: product.title!,
                              child: Image.network(product.image!, width: 100, height: 100,
                              fit: BoxFit.fill,
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
            });


          }else if( snapshot.hasError){
            return const Center(child: Text('Something went wrong'));

          }else{

            return const Center(child: CircularProgressIndicator());
          }

        },
      ),
    );
  }
}