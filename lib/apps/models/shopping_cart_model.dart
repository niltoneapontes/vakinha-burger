import 'dart:convert';

import 'package:vakinha_burger_mobile/apps/models/product_model.dart';

class ShoppingCartModel {
  int quantity;
  ProductModel product;

  ShoppingCartModel({
    required this.quantity,
    required this.product,
  });

  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'product': product.toMap(),
    };
  }

  factory ShoppingCartModel.fromMap(Map<String, dynamic> map) {
    return ShoppingCartModel(
      quantity: map['quantity']?.toInt() ?? 0,
      product: ProductModel.fromMap(map['product']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingCartModel.fromJson(String source) =>
      ShoppingCartModel.fromMap(json.decode(source));
}
