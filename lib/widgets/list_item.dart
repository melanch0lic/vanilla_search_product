import 'package:flutter/material.dart';
import 'package:flutter_education/models/product_model.dart';

class ListItem extends StatelessWidget {
  final ProductModel product;
  const ListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage(product.thumbnail),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title,
            maxLines: 2,
            style: const TextStyle(color: Colors.white, fontSize: 36),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            product.description,
            maxLines: 3,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
