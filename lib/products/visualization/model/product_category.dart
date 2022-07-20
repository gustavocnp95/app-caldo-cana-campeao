import 'package:caldo_cana_campeao/custom_widgets/dropdown_item.dart';

class ProductCategory implements DropdownItem {
  final int categoryId;
  final String categoryName;

  ProductCategory(this.categoryId, this.categoryName);

  @override
  String getDropdownLabel() {
    return categoryName;
  }

  @override
  bool operator ==(Object other) {
    if (other is ProductCategory) {
      return categoryId == other.categoryId;
    }
    return false;
  }
}
