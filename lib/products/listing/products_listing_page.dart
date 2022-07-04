import 'package:caldo_cana_campeao/products/listing/products_listing_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/campeao_app_bar.dart';

class ProductsListingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductsListingPageState();
}

class _ProductsListingPageState extends State<ProductsListingPage> {
  ProductsListingPageViewModel? _viewModel;
  bool _shouldShowError = false;

  @override
  void initState() {
    super.initState();
    _viewModel =
        Provider.of<ProductsListingPageViewModel>(context, listen: false);
    Future.delayed(Duration.zero, () {
      _viewModel?.fetchProducts(() {}, () {
        setState(() {
          _shouldShowError = true;
        });
      });
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
                itemCount: _viewModel?.products.length ?? 0,
                itemBuilder: (context, index) {
                  final product = _viewModel!.products[index];
                  return Text(product.name);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
