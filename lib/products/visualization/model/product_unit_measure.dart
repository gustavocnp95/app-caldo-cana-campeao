import 'package:caldo_cana_campeao/custom_widgets/dropdown_item.dart';

class ProductUnitMeasure extends DropdownItem {
  final String unitMeasure;

  ProductUnitMeasure(this.unitMeasure);

  @override
  String getDropdownLabel() {
    return unitMeasure;
  }

  @override
  bool operator ==(Object other) {
    if (other is ProductUnitMeasure) {
      return unitMeasure == other.unitMeasure;
    }
    return false;
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
