import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/apps/core/services/shopping_cart_service.dart';
import './product_detail_controller.dart';

class ProductDetailBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(
      ProductDetailController(
        shoppingCartService: Get.find<ShoppingCartService>(),
      ),
    );
  }
}
