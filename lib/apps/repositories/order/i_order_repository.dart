import 'package:vakinha_burger_mobile/apps/models/order.dart';
import 'package:vakinha_burger_mobile/apps/models/order_pix.dart';

abstract class IOrderRepository {
  Future<OrderPix>? createOrder(Order order) {}
}
