import 'package:vakinha_burger_mobile/apps/models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> findAll();
}
