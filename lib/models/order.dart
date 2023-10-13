// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:amazon_clone/models/product.dart';

class Order {
  final String id;
  final String address;
  final String userId;
  final String orderedAt;
  final int status;
  final List<Product> products;
  final List<int> quantity;
  Order({
    required this.id,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
    required this.products,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'address': address,
      'userId': userId,
      'orderedAt': orderedAt,
      'status': status,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
        id: map['_id'] as String,
        address: map['address'] as String,
        userId: map['userId'] as String,
        orderedAt: map['orderedAt'] as String,
        status: map['status'] as int,
        products: List<Product>.from(
          (map['products'] as List<int>).map<Product>(
            (x) => Product.fromMap(x as Map<String, dynamic>),
          ),
        ),
        quantity: List<int>.from(
          (map['quantity'] as List<int>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
