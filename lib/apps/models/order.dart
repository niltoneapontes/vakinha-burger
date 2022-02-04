import 'dart:convert';

import 'package:vakinha_burger_mobile/apps/models/shopping_cart_model.dart';

class Order {
  int userId;
  String cpf;
  String address;
  List<ShoppingCartModel> items;
  Order({
    required this.userId,
    required this.cpf,
    required this.address,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'cpf': cpf,
      'address': address,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      userId: map['userId']?.toInt() ?? 0,
      cpf: map['cpf'] ?? '',
      address: map['address'] ?? '',
      items: List<ShoppingCartModel>.from(
          map['items']?.map((x) => ShoppingCartModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
