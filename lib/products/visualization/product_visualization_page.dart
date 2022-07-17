import 'package:caldo_cana_campeao/custom_widgets/campeao_dropdown.dart';
import 'package:caldo_cana_campeao/products/visualization/model/product_type.dart';
import 'package:caldo_cana_campeao/products/visualization/model/product_visualization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../custom_widgets/campeao_app_bar.dart';

class ProductVisualizatioPage extends StatefulWidget {
  final ProductVisualization productVisualization;

  const ProductVisualizatioPage({required this.productVisualization}) : super();

  @override
  State<StatefulWidget> createState() => _ProductVisualizationPageState();
}

class _ProductVisualizationPageState extends State<ProductVisualizatioPage> {
  @override
  Widget build(BuildContext context) {
    return _createUi();
  }

  Widget _createUi() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CampeaoAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
            child: CampeaoDropdown(
              dropdownValue: widget.productVisualization.productType,
              values: ProductType.getAvailableTypes(),
            ),),
          ],
        ),
      ),
    );
  }
}