import 'dart:developer';

import 'package:vakinha_burger_mobile/apps/core/rest_client/rest_client.dart';
import 'package:vakinha_burger_mobile/apps/models/order_pix.dart';

import 'package:vakinha_burger_mobile/apps/models/order.dart';

import './i_order_repository.dart';

class OrderRepository implements IOrderRepository {
  final RestClient _restClient;

  OrderRepository({required RestClient restClient}) : _restClient = restClient;

  @override
  Future<OrderPix> createOrder(Order order) async {
    final result = await _restClient.post('/order/', {
      'userId': order.userId,
      'cpf': order.cpf,
      'address': order.address,
      'items': order.items
          .map((shoppingCart) => {
                'quantity': shoppingCart.quantity,
                'product': shoppingCart.product.id,
              })
          .toList(),
    });

    if (result.hasError) {
      log(
        'Erro ao realizar pedido ${result.statusCode}',
        error: result.statusText,
        stackTrace: StackTrace.current,
      );

      throw RestClientException('Erro ao realizar pedido');
    }

    return OrderPix.fromMap(result.body);
  }
}
