import 'package:caldo_cana_campeao/color/theme_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dropdown_item.dart';

class CampeaoDropdown extends StatefulWidget {
  DropdownItem? dropdownValue;
  List<DropdownItem> values;
  String? hint;
  bool isEditing;

  CampeaoDropdown({
    Key? key,
    required this.dropdownValue,
    required this.values,
    this.hint,
    this.isEditing = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CampeaoDropdownState();
}

class _CampeaoDropdownState extends State<CampeaoDropdown> {
  @override
  Widget build(final BuildContext context) {
    return Container(
      height: 55,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 0.8,
              style: BorderStyle.solid,
              color: widget.isEditing ? CampeaoColors.primaryColor : CampeaoColors.disabledColor),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<DropdownItem>(
          isExpanded: true,
          hint: widget.hint != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    widget.hint!,
                    style: const TextStyle(
                        color: CampeaoColors.primaryColor, fontSize: 15),
                  ),
                )
              : null,
          value: widget.dropdownValue,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: CampeaoColors.primaryColor,
          ),
          elevation: 16,
          style: const TextStyle(color: CampeaoColors.primaryTextColor),
          borderRadius: BorderRadius.circular(15),
          onChanged: widget.isEditing ? onItemChanged : null,
          items: widget.values
              .map<DropdownMenuItem<DropdownItem>>((DropdownItem item) {
            return DropdownMenuItem<DropdownItem>(
              value: item,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(item.getDropdownLabel()),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void onItemChanged(DropdownItem? item) {
    setState(() {
      widget.dropdownValue = item!;
    });
  }
}
