import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/apps/core/services/shopping_cart_service.dart';
import './home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        shoppingCartService: Get.find<ShoppingCartService>(),
      ),
    );
  }
}
