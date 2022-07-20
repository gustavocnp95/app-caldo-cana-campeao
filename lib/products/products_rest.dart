import 'package:caldo_cana_campeao/products/model/product_response.dart';
import 'package:caldo_cana_campeao/products/visualization/model/category_response.dart';
import 'package:http/http.dart' as http;

import '../commons/campeao_json.dart';
import '../commons/network/network_constants.dart';

class ProductsRest {
  Future<List<ProductResponse>> getAll() async {
    final response = await http.get(
      Uri.parse(CampeaoNetworkConstants.wsUrl + "products"),
      headers: CampeaoNetworkConstants.headers,
    );
    if (response.statusCode == CampeaoNetworkConstants.statusOk) {
      final Iterable l = CampeaoJson.decode(response.bodyBytes);
      return List<ProductResponse>.from(
          l.map((productJson) => ProductResponse.fromJson(productJson)));
    } else {
      throw Exception("Error when getting products");
    }
  }

  Future<List<CategoryResponse>> getAllCategories() async {
    final response = await http.get(
      Uri.parse(CampeaoNetworkConstants.wsUrl + "categories"),
      headers: CampeaoNetworkConstants.headers,
    );
    if (response.statusCode == CampeaoNetworkConstants.statusOk) {
      final Iterable l = CampeaoJson.decode(response.bodyBytes);
      return List<CategoryResponse>.from(
          l.map((categoryJson) => CategoryResponse.fromJson(categoryJson)));
    } else {
      throw Exception("Error when getting categories");
    }
  }
}
