import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vakinha_burger_mobile/apps/core/services/auth_service.dart';
import 'package:vakinha_burger_mobile/apps/core/services/shopping_cart_service.dart';
import 'package:vakinha_burger_mobile/apps/modules/menu/menu_bindings.dart';
import 'package:vakinha_burger_mobile/apps/modules/menu/menu_page.dart';
import 'package:vakinha_burger_mobile/apps/modules/order/shopping_cart/shopping_cart_bindings.dart';
import 'package:vakinha_burger_mobile/apps/modules/order/shopping_cart/shopping_cart_page.dart';

class HomeController extends GetxController {
  // ignore: constant_identifier_names
  static const NAVIGATOR_KEY = 1;
  final ShoppingCartService _shoppingCartService;

  HomeController({
    required shoppingCartService,
  }) : _shoppingCartService = shoppingCartService;

  final _tabIndex = 0.obs;
  final _tabs = ['/menu', '/order/shopping_cart', '/exit'];

  int get tabIndex => _tabIndex.value;

  int get totalProductsInShoppingCart => _shoppingCartService.totalProducts;

  set tabIndex(int index) {
    _tabIndex(index);
    if (_tabs[index] == '/exit') {
      Get.find<AuthService>().logout();
    } else {
      Get.toNamed(_tabs[index], id: NAVIGATOR_KEY);
    }
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/menu') {
      return GetPageRoute(
        settings: settings,
        page: () => const MenuPage(),
        binding: MenuBindings(),
        transition: Transition.fadeIn,
      );
    }

    if (settings.name == '/order/shopping_cart') {
      return GetPageRoute(
        settings: settings,
        page: () => ShoppingCartPage(),
        binding: ShoppingCartBindings(),
        transition: Transition.fadeIn,
      );
    }
  }
}
