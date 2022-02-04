import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/apps/core/services/auth_service.dart';
import 'package:vakinha_burger_mobile/apps/core/services/shopping_cart_service.dart';
import 'package:vakinha_burger_mobile/apps/models/order.dart';
import 'package:vakinha_burger_mobile/apps/models/shopping_cart_model.dart';
import 'package:vakinha_burger_mobile/apps/modules/home/home_controller.dart';
import 'package:vakinha_burger_mobile/apps/repositories/order/order_repository.dart';

class ShoppingCartController extends GetxController {
  final AuthService _authService;
  final ShoppingCartService _shoppingCartService;
  final OrderRepository _orderRepository;

  ShoppingCartController({
    required AuthService authService,
    required ShoppingCartService shoppingCartService,
    required OrderRepository orderRepository,
  })  : _authService = authService,
        _shoppingCartService = shoppingCartService,
        _orderRepository = orderRepository;

  final _address = ''.obs;
  final _cpf = ''.obs;

  List<ShoppingCartModel> get products => _shoppingCartService.products;

  double get totalValue => _shoppingCartService.totalValue;

  set address(String value) => _address.value = value;
  set cpf(String value) => _cpf.value = value;

  void addQuantityInProduct(ShoppingCartModel shoppingCartModel) {
    _shoppingCartService.addAndRemoveProductInShoppingCart(
        shoppingCartModel.product,
        quantity: shoppingCartModel.quantity + 1);
  }

  void subtractQuantityInProduct(ShoppingCartModel shoppingCartModel) {
    _shoppingCartService.addAndRemoveProductInShoppingCart(
        shoppingCartModel.product,
        quantity: shoppingCartModel.quantity - 1);
  }

  void clear() => _shoppingCartService.clear();

  Future<void> createOrder() async {
    final userId = _authService.getUserId();

    final order = Order(
      userId: userId!,
      cpf: _cpf.value,
      address: _address.value,
      items: products,
    );

    var orderPix = await _orderRepository.createOrder(order);
    orderPix = orderPix.copyWith(value: _shoppingCartService.totalValue);

    Get.offNamed('/orders/finished', arguments: orderPix);
    Get.back(id: HomeController.NAVIGATOR_KEY);
    _shoppingCartService.clear();
  }
}
