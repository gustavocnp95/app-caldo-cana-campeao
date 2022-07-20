import 'package:caldo_cana_campeao/custom_widgets/dropdown_item.dart';

class ProductUnitMeasure extends DropdownItem {
  final String unitMeasure;

  ProductUnitMeasure(this.unitMeasure);

  @override
  String getDropdownLabel() {
    return unitMeasure;
  }

  static List<ProductUnitMeasure> getAvailableUnits() {
    return [
      ProductUnitMeasure("kg"),
      ProductUnitMeasure("g"),
      ProductUnitMeasure("mg"),
      ProductUnitMeasure("un"),
      ProductUnitMeasure("l"),
      ProductUnitMeasure("ml"),
    ];
  }
}
