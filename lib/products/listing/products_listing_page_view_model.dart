import 'package:caldo_cana_campeao/products/model/product_response.dart';
import 'package:flutter/material.dart';

import '../products_repository.dart';

class ProductsListingPageViewModel extends ChangeNotifier {
  final ProductRepository _repository = ProductRepository();
  bool _doingAsyncOperation = false;
  List<ProductResponse> products = List.empty();

  bool get doingAsyncOperation => _doingAsyncOperation;

  void fetchProducts(
    Function onSuccess,
    Function onError,
  ) {
    _setDoingAsyncOperation(true);
    _repository
        .getAll()
        .catchError((error, stackTrace) {
          _onFetchProductsError(error, onError);
        })
        .then((productsResponse) => _onFetchProductsSuccess(productsResponse, onSuccess))
        .whenComplete(() => _setDoingAsyncOperation(false));
  }

  void _onFetchProductsSuccess(
    List<ProductResponse> productsResponse,
    Function onSucessCallback,
  ) {
    products = productsResponse;
    notifyListeners();
    onSucessCallback();
  }

  void _onFetchProductsError(Exception e, Function onErrorCallback) {
    onErrorCallback();
  }

  void _setDoingAsyncOperation(bool doingAsyncOperation) {
    _doingAsyncOperation = doingAsyncOperation;
    notifyListeners();
  }
}
