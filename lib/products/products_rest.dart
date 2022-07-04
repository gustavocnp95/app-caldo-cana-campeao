import 'dart:convert';

import 'package:caldo_cana_campeao/products/model/product_response.dart';
import 'package:http/http.dart' as http;

import '../commons/network/network_constants.dart';

class ProductsRest {
  Future<List<ProductResponse>> getAll() async {
    final response = await http.get(
      Uri.parse(CampeaoNetworkConstants.wsUrl + "products"),
      headers: CampeaoNetworkConstants.headers,
    );
    if (response.statusCode == CampeaoNetworkConstants.statusOk) {
      final Iterable l = json.decode(response.body);
      return List<ProductResponse>.from(
          l.map((userJson) => ProductResponse.fromJson(userJson)));
    } else {
      throw Exception("Error when getting products");
    }
  }
}
