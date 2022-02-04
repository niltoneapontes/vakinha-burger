import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/apps/repositories/order/order_repository.dart';
import './shopping_cart_controller.dart';

class ShoppingCartBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => OrderRepository(
        restClient: Get.find(),
      ),
    );
    Get.put(
      ShoppingCartController(
        authService: Get.find(),
        shoppingCartService: Get.find(),
        orderRepository: Get.find(),
      ),
    );
  }
}
