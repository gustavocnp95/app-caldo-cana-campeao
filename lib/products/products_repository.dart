import 'package:caldo_cana_campeao/products/products_rest.dart';

import 'model/product_response.dart';

class ProductRepository {
  final ProductsRest _productsRest = ProductsRest();
  
  Future<List<ProductResponse>> getAll() {
    return _productsRest.getAll();
  }
}