import 'package:caldo_cana_campeao/products/visualization/model/category_response.dart';
import 'package:flutter/material.dart';

import '../products_repository.dart';

class ProductsVisualizationPageViewModel extends ChangeNotifier {
  final ProductRepository _repository = ProductRepository();
  bool _doingAsyncOperation = false;
  List<CategoryResponse> categories = List.empty();

  bool get doingAsyncOperation => _doingAsyncOperation;

  void fetchCategories(
      Function onSuccess,
      Function onError,
      ) {
    _setDoingAsyncOperation(true);
    _repository
        .getAllCategories()
        .catchError((error, stackTrace) {
      _onFetchProductsError(error, onError);
    })
        .then((categoriesResposne) => _onFetchProductsSuccess(categoriesResposne, onSuccess))
        .whenComplete(() => _setDoingAsyncOperation(false));
  }

  void _onFetchProductsSuccess(
      List<CategoryResponse> categoriesResponse,
      Function onSucessCallback,
      ) {
    categories = categoriesResponse;
    notifyListeners();
    onSucessCallback(categoriesResponse);
  }

  void _onFetchProductsError(Exception e, Function onErrorCallback) {
    onErrorCallback();
  }

  void _setDoingAsyncOperation(bool doingAsyncOperation) {
    _doingAsyncOperation = doingAsyncOperation;
    notifyListeners();
  }
}