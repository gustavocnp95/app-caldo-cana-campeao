import 'package:caldo_cana_campeao/color/theme_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dropdown_item.dart';

class CampeaoDropdown extends StatefulWidget {
  DropdownItem? dropdownValue;
  List<DropdownItem> values;
  String? hint;

  CampeaoDropdown({
    Key? key,
    required this.dropdownValue,
    required this.values,
    this.hint,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CampeaoDropdownState();
}

class _CampeaoDropdownState extends State<CampeaoDropdown> {
  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1.0,
              style: BorderStyle.solid,
              color: CampeaoColors.primaryColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<DropdownItem>(
          hint: widget.hint != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    widget.hint!,
                    style: const TextStyle(color: CampeaoColors.primaryColor),
                  ),
                )
              : null,
          value: widget.dropdownValue,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: CampeaoColors.primaryColor,
          ),
          elevation: 16,
          style: const TextStyle(color: CampeaoColors.primaryColor),
          borderRadius: BorderRadius.circular(15),
          onChanged: (DropdownItem? item) {
            setState(() {
              widget.dropdownValue = item!;
            });
          },
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
}
