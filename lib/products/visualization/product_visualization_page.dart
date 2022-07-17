import 'package:caldo_cana_campeao/custom_widgets/campeao_dropdown.dart';
import 'package:caldo_cana_campeao/products/visualization/model/product_type.dart';
import 'package:caldo_cana_campeao/products/visualization/model/product_visualization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../custom_widgets/campeao_app_bar.dart';
import 'model/product_category.dart';

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
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 24),
                child: Text(
                  "Produto",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 32),
              ),
              Row(
                children: [
                  Expanded(
                    child: CampeaoDropdown(
                      hint: "Tipo do Produto",
                      dropdownValue: widget.productVisualization.productType,
                      values: ProductType.getAvailableTypes(),
                    ),
                  ),
                  Container(padding: EdgeInsets.only(left: 4, right: 4),),
                  Expanded(
                    child: CampeaoDropdown(
                      hint: "Categoria do Produto",
                      dropdownValue:
                          widget.productVisualization.productCategory,
                      values: [
                        ProductCategory(1, "Categoria 1"),
                        ProductCategory(2, "Categoria 2")
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
