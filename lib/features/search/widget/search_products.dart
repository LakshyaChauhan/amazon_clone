import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class SearchProducts extends StatelessWidget {
  const SearchProducts({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.fitHeight,
                height: 135,
                width: 135,
              )
            ],
          ),
        ),
      ],
    );
  }
}
