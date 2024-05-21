import 'product_model.dart';

class ProductsModel {
  final List<ProductModel> products;

  ProductsModel({required this.products});

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
        products: (json['products'] as List<dynamic>)
            .map((product) => ProductModel.fromJson(product as Map<String, dynamic>))
            .toList());
  }
}
