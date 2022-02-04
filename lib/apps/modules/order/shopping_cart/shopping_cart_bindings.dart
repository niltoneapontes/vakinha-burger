import 'package:get/get.dart';
import './shopping_cart_controller.dart';

class ShoppingCartBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(
      ShoppingCartController(
        authService: Get.find(),
        shoppingCartService: Get.find(),
        orderRepository: Get.find(),
      ),
    );
  }
}
