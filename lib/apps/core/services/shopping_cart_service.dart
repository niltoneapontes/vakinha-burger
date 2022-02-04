import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/apps/models/product_model.dart';
import 'package:vakinha_burger_mobile/apps/models/shopping_cart_model.dart';

class ShoppingCartService extends GetxService {
  final _shoppingCart = <int, ShoppingCartModel>{}.obs;

  List<ShoppingCartModel> get products => _shoppingCart.values.toList();

  int get totalProducts => _shoppingCart.values.length;

  ShoppingCartModel? getbyId(int id) => _shoppingCart[id];

  double get totalValue {
    return _shoppingCart.values.fold(0, (totalValue, shoppingCartModel) {
      totalValue +=
          shoppingCartModel.quantity * shoppingCartModel.product.price;
      return totalValue;
    });
  }

  void addAndRemoveProductInShoppingCart(ProductModel product,
      {required int quantity}) {
    if (quantity == 0) {
      _shoppingCart.remove(product.id);
    } else {
      _shoppingCart.update(product.id, (product) {
        product.quantity = quantity;
        return product;
      }, ifAbsent: () {
        return ShoppingCartModel(quantity: quantity, product: product);
      });
    }
  }

  void clear() => _shoppingCart.clear();
}
