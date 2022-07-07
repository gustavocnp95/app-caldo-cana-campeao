import 'package:caldo_cana_campeao/commons/iterable_extensions.dart';
import 'package:caldo_cana_campeao/products/listing/products_listing_page_view_model.dart';
import 'package:caldo_cana_campeao/products/model/product_response.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../color/theme_colors.dart';
import '../../custom_widgets/campeao_app_bar.dart';

class ProductsListingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductsListingPageState();
}

class _ProductsListingPageState extends State<ProductsListingPage> {
  ProductsListingPageViewModel? _viewModel;
  bool _shouldShowError = false;
  List<Widget> _itemsList = List.empty();

  @override
  void initState() {
    super.initState();
    _viewModel =
        Provider.of<ProductsListingPageViewModel>(context, listen: false);
    Future.delayed(Duration.zero, () {
      _viewModel?.fetchProducts((List<ProductResponse> productsResponse) {
        _onFetchProductsSuccess(productsResponse);
      }, () {
        _onFetchProductsError();
      });
    });
  }

  void _onFetchProductsError() {
    setState(() {
      _shouldShowError = true;
    });
  }

  void _onFetchProductsSuccess(List<ProductResponse> productsResponse) {
    List<Widget> itemsList = [];
    productsResponse.groupBy((product) => product.category).forEach(
      (category, products) {
        itemsList.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              category,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
        for (var product in products) {
          itemsList.add(
            Row(
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
                    product.qtt.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      product.saleValue.toString(),
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
            ),
          );
        }
      },
    );
    setState(() {
      _itemsList = itemsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ProductsListingPageViewModel>();
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
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _itemsList.length,
                itemBuilder: (context, index) {
                  return _itemsList[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
