import 'package:caldo_cana_campeao/commons/iterable_extensions.dart';
import 'package:caldo_cana_campeao/custom_widgets/campeao_elevated_button.dart';
import 'package:caldo_cana_campeao/custom_widgets/campeao_text_field.dart';
import 'package:caldo_cana_campeao/products/listing/products_listing_page_view_model.dart';
import 'package:caldo_cana_campeao/products/model/product_response.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../color/theme_colors.dart';
import '../../custom_widgets/app_error.dart';
import '../../custom_widgets/app_loading.dart';
import '../../custom_widgets/campeao_app_bar.dart';

class ProductsListingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductsListingPageState();
}

class _ProductsListingPageState extends State<ProductsListingPage> {
  ProductsListingPageViewModel? _viewModel;
  bool _shouldShowError = false;
  bool _elevatedFinalButtonSelected = false;
  bool _elevatedCompostoButtonSelected = false;
  bool _elevatedMateriaPrimaButtonSelected = false;
  String? _searchProductText;
  List<Widget> _showedItemsList = List.empty();

  @override
  void initState() {
    super.initState();
    _viewModel =
        Provider.of<ProductsListingPageViewModel>(context, listen: false);
    Future.delayed(Duration.zero, () {
      tryToFetchProducts();
    });
  }

  void tryToFetchProducts() {
    _viewModel?.fetchProducts((List<ProductResponse> productsResponse) {
      _onFetchProductsSuccess(productsResponse);
    }, () {
      _onFetchProductsError();
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ProductsListingPageViewModel>();
    if (_viewModel?.doingAsyncOperation ?? false) {
      return AppLoading();
    }
    if (_shouldShowError) {
      return AppError(
        actionBtnTitle: "Tentar novamente",
        onActionBtnClick: () {
          setState(() {
            _shouldShowError = false;
            tryToFetchProducts();
          });
        },
      );
    }
    return _createUi();
  }

  Widget _createUi() {
    return Scaffold(
      appBar: const CampeaoAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: Text(
                "Produtos",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            CampeaoInputTextField(
              hintText: "Pesquisar produto",
              initialText: _searchProductText,
              onTextChanged: (newText) {
                setState(() {
                  _searchProductText = newText;
                  _refreshShowedItemsList(_viewModel!.products);
                });
              },
              prefixIconButton: IconButton(
                icon: const Icon(Icons.search),
                color: CampeaoColors.primaryColorDark,
                onPressed: () {},
              ),
              suffixIconButton: IconButton(
                icon: const Icon(Icons.close_rounded),
                color: CampeaoColors.primaryColor,
                onPressed: () {
                  setState(() {
                    _searchProductText = null;
                  });
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CampeaoElevatedButton(
                    buttonText: "Composto",
                    onPressed: () {
                      setState(() {
                        _elevatedCompostoButtonSelected =
                            !_elevatedCompostoButtonSelected;
                        _refreshShowedItemsList(_viewModel!.products);
                      });
                    },
                    fontSize: 14,
                    minHeight: 20,
                    isSelected: _elevatedCompostoButtonSelected,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 9),
                    child: CampeaoElevatedButton(
                      buttonText: "Final",
                      onPressed: () {
                        setState(() {
                          _elevatedFinalButtonSelected =
                              !_elevatedFinalButtonSelected;
                          _refreshShowedItemsList(_viewModel!.products);
                        });
                      },
                      fontSize: 14,
                      minHeight: 20,
                      isSelected: _elevatedFinalButtonSelected,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 9),
                    child: CampeaoElevatedButton(
                      buttonText: "Matéria-Prima",
                      onPressed: () {
                        setState(() {
                          _elevatedMateriaPrimaButtonSelected =
                              !_elevatedMateriaPrimaButtonSelected;
                          _refreshShowedItemsList(_viewModel!.products);
                        });
                      },
                      fontSize: 14,
                      minHeight: 20,
                      isSelected: _elevatedMateriaPrimaButtonSelected,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _showedItemsList.length,
                itemBuilder: (context, index) {
                  return _showedItemsList[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onFetchProductsError() {
    setState(() {
      _shouldShowError = true;
    });
  }

  void _onFetchProductsSuccess(List<ProductResponse> productsResponse) {
    _refreshShowedItemsList(productsResponse);
  }

  void _refreshShowedItemsList(List<ProductResponse> productsResponse) {
    List<Widget> itemsList = [];
    productsResponse.groupBy((product) => product.category).forEach(
      (category, products) {
        if (isAnyElevatedButtonFilterApplied()) {
          if (category.toUpperCase() == "FINAL" &&
              !_elevatedFinalButtonSelected) {
            return;
          }
          if (category.toUpperCase() == "COMPOSTO" &&
              !_elevatedCompostoButtonSelected) {
            return;
          }
          if (category.toUpperCase() == "MATERIA-PRIMA" &&
              !_elevatedMateriaPrimaButtonSelected) {
            return;
          }
        }
        List<Widget> productsItems = [];
        for (var product in products) {
          if (_searchProductText == null ||
              _searchProductText!.isEmpty ||
              product.name
                  .toUpperCase()
                  .contains(_searchProductText!.toUpperCase())) {
            productsItems.add(
              _createProductItem(product),
            );
          }
        }
        if (productsItems.isNotEmpty) {
          itemsList.add(
            _createProductCategoryItem(category),
          );
          itemsList.addAll(productsItems);
        }
      },
    );
    setState(() {
      _showedItemsList = itemsList;
    });
  }

  bool isAnyElevatedButtonFilterApplied() {
    return _elevatedMateriaPrimaButtonSelected ||
        _elevatedCompostoButtonSelected ||
        _elevatedFinalButtonSelected;
  }

  Row _createProductItem(ProductResponse product) {
    return Row(
      children: [
        Expanded(
          child: Text(
            product.name,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Expanded(
          child: Text(
            "${NumberFormat.decimalPattern("pt_BR").format(product.qtt)} ${product.unMeasure.toUpperCase()}",
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              NumberFormat.simpleCurrency(locale: "pt_BR")
                  .format(product.saleValue),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            IconButton(
                iconSize: 30,
                icon: const Icon(Icons.edit),
                color: CampeaoColors.primaryColor,
                onPressed: () {}),
          ],
        ),
      ],
    );
  }

  Padding _createProductCategoryItem(String category) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Text(
        category,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
