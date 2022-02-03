import 'dart:developer';

import 'package:get/get.dart';
import 'package:vakinha_burger_mobile/apps/core/mixin/loader_mixin.dart';
import 'package:vakinha_burger_mobile/apps/core/mixin/messages_mixin.dart';
import 'package:vakinha_burger_mobile/apps/models/product_model.dart';

import 'package:vakinha_burger_mobile/apps/repositories/products/product_repository.dart';

class MenuController extends GetxController with LoaderMixin, MessagesMixin {
  final _loading = false.obs;
  final _message = Rxn<MessageModel>();
  final menu = <ProductModel>[].obs;

  ProductRepository _productRepository;

  MenuController({
    required ProductRepository productRepository,
  }) : _productRepository = productRepository;

  @override
  void onInit() {
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    try {
      _loading.toggle();
      await findAllProducts();
      _loading.toggle();
    } catch (e, s) {
      log('Erro ao buscar produtos');
      _message(MessageModel(
        title: 'Erro',
        message: 'Não foi possível buscar produtos',
        type: MessageType.error,
      ));
    }
  }

  Future<void> findAllProducts() async {
    final products = await _productRepository.findAll();
    menu.assignAll(products);
  }

  @override
  Future<void> refresh() async {
    try {
      await findAllProducts();
    } catch (e, s) {
      log('Erro ao buscar produtos');
    }
  }
}
