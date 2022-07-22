import 'package:caldo_cana_campeao/commons/decimal_formatter.dart';
import 'package:caldo_cana_campeao/products/visualization/model/product_category.dart';
import 'package:caldo_cana_campeao/products/visualization/model/product_type.dart';
import 'package:caldo_cana_campeao/products/visualization/model/product_unit_measure.dart';

class ProductVisualization {
  ProductType? productType;
  ProductCategory? productCategory;
  ProductUnitMeasure? unitMeasure;
  String? productDescription;
  String? sellingPrice;
  String? buyingPrice;
  String? quantity;

  ProductVisualization(
      this.productType,
      this.productCategory,
      this.unitMeasure,
      this.productDescription,
      this.sellingPrice,
      this.buyingPrice,
      this.quantity);
}