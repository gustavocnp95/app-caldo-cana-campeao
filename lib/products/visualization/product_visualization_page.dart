import 'package:caldo_cana_campeao/custom_widgets/campeao_dropdown.dart';
import 'package:caldo_cana_campeao/custom_widgets/campeao_text_field.dart';
import 'package:caldo_cana_campeao/products/visualization/model/category_response.dart';
import 'package:caldo_cana_campeao/products/visualization/model/product_type.dart';
import 'package:caldo_cana_campeao/products/visualization/model/product_unit_measure.dart';
import 'package:caldo_cana_campeao/products/visualization/model/product_visualization.dart';
import 'package:caldo_cana_campeao/products/visualization/model/product_visualization_composition.dart';
import 'package:caldo_cana_campeao/products/visualization/product_visualization_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../color/theme_colors.dart';
import '../../commons/decimal_formatter.dart';
import '../../custom_widgets/app_error.dart';
import '../../custom_widgets/app_loading.dart';
import '../../custom_widgets/campeao_app_bar.dart';
import 'model/product_category.dart';

class ProductVisualizationPage extends StatefulWidget {
  final ProductVisualization productVisualization;
  final bool isEditing;

  const ProductVisualizationPage({
    Key? key,
    required this.productVisualization,
    this.isEditing = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductVisualizationPageState();
}

class _ProductVisualizationPageState extends State<ProductVisualizationPage> {
  ProductsVisualizationPageViewModel? _viewModel;
  bool _shouldShowError = false;
  List<ProductCategory> categories = [];
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _viewModel =
        Provider.of<ProductsVisualizationPageViewModel>(context, listen: false);
    Future.delayed(Duration.zero, () {
      _tryToFetchCategories();
    });
    isEditing = widget.isEditing;
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ProductsVisualizationPageViewModel>();
    if (_viewModel?.doingAsyncOperation ?? false) {
      return AppLoading();
    }
    if (_shouldShowError) {
      return AppError(
        actionBtnTitle: "Tentar novamente",
        onActionBtnClick: () {
          setState(() {
            _shouldShowError = false;
            _tryToFetchCategories();
          });
        },
      );
    }
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
            mainAxisSize: MainAxisSize.min,
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
                      isEditing: isEditing,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 4, right: 4),
                  ),
                  Expanded(
                    child: CampeaoDropdown(
                      hint: "Categoria do Produto",
                      dropdownValue:
                          widget.productVisualization.productCategory,
                      values: categories,
                      isEditing: isEditing,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: CampeaoInputTextField(
                        enabled: isEditing,
                        initialText:
                            widget.productVisualization.productDescription,
                        hintText: "Nome do produto",
                        onTextChanged: (newText) {
                          widget.productVisualization.productDescription =
                              newText;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: CampeaoInputTextField(
                        enabled: isEditing,
                        textInputType: TextInputType.number,
                        textInputFormatters: [DecimalFormatter()],
                        initialText: widget.productVisualization.quantity,
                        hintText: "Quantidade",
                        onTextChanged: (newText) {
                          widget.productVisualization.quantity = newText;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                    ),
                    Expanded(
                      child: CampeaoDropdown(
                        dropdownValue: widget.productVisualization.unitMeasure,
                        values: ProductUnitMeasure.getAvailableUnits(),
                        hint: "Unidade de Medida",
                        isEditing: isEditing,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: CampeaoInputTextField(
                        enabled: isEditing,
                        hintText: "Compra",
                        prefixText: "R\$",
                        textInputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        textInputFormatters: [DecimalFormatter()],
                        initialText: widget.productVisualization.buyingPrice,
                        onTextChanged: (newText) {
                          widget.productVisualization.buyingPrice = newText;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                    ),
                    Expanded(
                      child: CampeaoInputTextField(
                        hintText: "Venda",
                        prefixText: "R\$",
                        textInputType: const TextInputType.numberWithOptions(
                            decimal: true),
                        textInputFormatters: [DecimalFormatter()],
                        initialText: widget.productVisualization.sellingPrice,
                        enabled: isEditing,
                        onTextChanged: (newText) {
                          widget.productVisualization.sellingPrice = newText;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 24),
                child: Text(
                  "Composição",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        "Item",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Valor",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Un. Medida",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      "Ação",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 0),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: widget.productVisualization.composition?.length,
                  itemBuilder: (context, index) {
                    final productComposition =
                        widget.productVisualization.composition![index];
                    return _createCompositionItem(productComposition);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createCompositionItem(
      ProductVisualizationComposition productComposition) {
    return Row(
      children: [
        Expanded(
          child: Text(
            productComposition.name,
            style: const TextStyle(fontSize: 17),
          ),
        ),
        Expanded(
          child: Container(
            child: CampeaoInputTextField(
              initialText: productComposition.qtt,
              onTextChanged: (newText) {
                productComposition.qtt = newText;
              },
              isUnderlined: true,
              enabled: false,
              textInputType:
                  const TextInputType.numberWithOptions(decimal: true),
              textInputFormatters: [DecimalFormatter()],
              backgroundColor: Colors.transparent,
              fontSize: 17,
            ),
          ),
        ),
        Expanded(
          child: Text(
            productComposition.unMeasure,
            style: const TextStyle(fontSize: 17),
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
            onPressed: isEditing
                ? () {
                    _onDeleteItemClicked(productComposition);
                  }
                : null,
            icon: Icon(
              Icons.delete_forever_outlined,
              color: isEditing ? CampeaoColors.primaryColor : Colors.grey,
            )),
      ],
    );
  }

  void _onDeleteItemClicked(
      ProductVisualizationComposition productComposition) {}

  void _tryToFetchCategories() {
    _viewModel?.fetchCategories((List<CategoryResponse> categoriesResponse) {
      _onFetchProductsSuccess(categoriesResponse);
    }, () {
      _onFetchProductsError();
    });
  }

  void _onFetchProductsError() {
    setState(() {
      _shouldShowError = true;
    });
  }

  void _onFetchProductsSuccess(List<CategoryResponse> categoriesResponse) {
    categories = categoriesResponse.map((category) {
      return ProductCategory(category.id, category.name);
    }).toList();
  }
}
