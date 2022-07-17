import 'package:caldo_cana_campeao/custom_widgets/dropdown_item.dart';

class ProductType implements DropdownItem {
  final String typeName;

  ProductType(this.typeName);

  @override
  String getDropdownLabel() {
    return typeName;
  }

  static List<ProductType> getAvailableTypes() {
    return [
      ProductType("Final"),
      ProductType("Composto"),
      ProductType("Matéria-Prima"),
    ];
  }
}
