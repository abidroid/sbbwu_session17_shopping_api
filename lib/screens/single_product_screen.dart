import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sbbwu_session17_shopping_api/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:sbbwu_session17_shopping_api/screens/product_list_screen.dart';

class SingleProductScreen extends StatefulWidget {
  const SingleProductScreen({super.key});

  @override
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {

  Future<Product> getSingleProduct() async {
    // Endpoint
    try{
      String url = 'https://fakestoreapi.com/products/6';

      http.Response response = await http.get(Uri.parse(url));
      print('Response Code ${response.statusCode}');

      if (response.statusCode == 200) {
        print('Response ${response.body}');
        var jsonResponse = jsonDecode(response.body);

        Product product = Product.fromJson(jsonResponse);

        await Future.delayed(const Duration(seconds: 3));
        return product;
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e, st){
     print(e) ;
     print(st);
     return Product();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single Product'),
      ),
      body: FutureBuilder<Product>(
        future: getSingleProduct(),
        builder: (context, snapshot){

          if( snapshot.hasData){

            Product product = snapshot.data!;

            return Center(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [

                  Image.network(product.image!, width: 200, height: 200,),

                  Text(product.title!),
                  const Divider(),
                  Text(product.description!),
                  const Divider(),
                  Text('Price: \$${product.price}'),
                  const Divider(),
                  Text('Rating: ${product.rating!.rate!}'),
                  const Divider(),
                  TextButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return const ProductListScreen();
                    }));
                  }, child: const Text('View All'))

                ],
              ),
            ),);

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
