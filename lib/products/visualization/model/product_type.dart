import 'package:caldo_cana_campeao/custom_widgets/dropdown_item.dart';

class ProductType implements DropdownItem {
  final String typeName;

  ProductType(this.typeName);

  @override
  String getDropdownLabel() {
    return typeName;
  }


  @override
  bool operator ==(Object other) {
    if (other is ProductType) {
      return typeName == other.typeName;
    }
    return false;
  }

  static List<ProductType> getAvailableTypes() {
    return [
      ProductType("final"),
      ProductType("composto"),
      ProductType("materia_prima"),
    ];
  }
}
