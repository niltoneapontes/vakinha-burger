import 'package:get/get.dart';

import 'package:vakinha_burger_mobile/apps/core/services/shopping_cart_service.dart';
import 'package:vakinha_burger_mobile/apps/models/product_model.dart';

class ProductDetailController extends GetxController {
  final _product = Rx<ProductModel>(Get.arguments);
  final _totalPrice = 0.0.obs;
  final _quantity = 0.obs;
  final ShoppingCartService _shoppingCartService;
  final _alreadyAdded = false.obs;

  ProductDetailController({
    required shoppingCartService,
  }) : _shoppingCartService = shoppingCartService;

  ProductModel get product => _product.value;
  double get totalPrice => _totalPrice.value;
  int get quantity => _quantity.value;
  bool get alreadyAdded => _alreadyAdded.value;

  @override
  void onInit() {
    _totalPrice(product.price);
    super.onInit();

    ever<int>(_quantity, (quantity) {
      _totalPrice(product.price * quantity);
    });

    final productShoppingCart = _shoppingCartService.getbyId(product.id);

    if (productShoppingCart != null) {
      _quantity(productShoppingCart.quantity);
      _alreadyAdded(true);
    }
  }

  void addProduct() {
    _quantity.value += 1;
  }

  void removeProduct() {
    if (_quantity.value > 1) {
      _quantity.value += 1;
    }
  }

  void addProductInShoppingCart() {
    _shoppingCartService.addAndRemoveProductInShoppingCart(product,
        quantity: quantity);
    Get.back();
  }
}
