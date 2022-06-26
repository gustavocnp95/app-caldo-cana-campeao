import 'package:flutter/material.dart';

import '../../custom_widgets/campeao_app_bar.dart';

class ProductsListingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductsListingPageState();
}

class _ProductsListingPageState extends State<ProductsListingPage> {
  @override
  Widget build(BuildContext context) {
    return _createUi();
  }

  Widget _createUi() {
    return Scaffold(
      appBar: const CampeaoAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: Text(
                "Produtos",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
