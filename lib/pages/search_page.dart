import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_education/models/products_model.dart';

import '../models/product_model.dart';
import '../widgets/list_item.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final Dio _dio;
  SearchStatus _searchStatus = SearchStatus.initial;
  List<ProductModel> products = [];

  @override
  initState() {
    _dio = Dio()..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    super.initState();
  }

  Future<void> searchProducts(String searchValue) async {
    if (searchValue.isEmpty) {
      setState(() {
        _searchStatus = SearchStatus.initial;
      });
      return;
    }
    setState(() {
      _searchStatus = SearchStatus.loading;
    });

    try {
      final result = await _dio.get('https://dummyjson.com/products/search?q=$searchValue');
      setState(() {
        products = ProductsModel.fromJson(result.data as Map<String, dynamic>).products;
        _searchStatus = SearchStatus.success;
      });
    } catch (error) {
      debugPrint(error.toString());
      setState(() {
        _searchStatus = SearchStatus.failure;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Поиск продуктов'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => searchProducts(value),
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(child: Builder(builder: (context) {
              switch (_searchStatus) {
                case SearchStatus.initial:
                  return const Center(child: Text('Начните поиск'));
                case SearchStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case SearchStatus.success:
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) => ListItem(product: products[index]),
                  );
                case SearchStatus.failure:
                  return const Center(child: Text('Произошла ошибка'));
              }
            })),
          ],
        ),
      ),
    );
  }
}
