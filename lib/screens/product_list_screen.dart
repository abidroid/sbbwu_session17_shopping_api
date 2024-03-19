import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbbwu_session17_shopping_api/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:sbbwu_session17_shopping_api/screens/product_detail_screen.dart';
import 'package:sbbwu_session17_shopping_api/widgets/product_list_widget.dart';

import '../widgets/product_grid_widget.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool isList = false;

  Future<List<Product>> getAllProducts() async {
    List<Product> productList = [];

    http.Response response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      for (var jsonProduct in jsonResponse) {
        Product product = Product.fromJson(jsonProduct);

        productList.add(product);
      }

      return productList;
    } else {
      throw Exception('Something Went Wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isList = !isList;
                });
              },
              icon: Icon(isList ? Icons.grid_4x4 : Icons.list))
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = snapshot.data!;

            return isList
                ? ProductListWidget(products: products)
                : ProductGridWidget(products: products);
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
