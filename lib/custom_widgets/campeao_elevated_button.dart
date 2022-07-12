import 'package:flutter/material.dart';

import '../color/theme_colors.dart';

class CampeaoElevatedButton extends StatelessWidget {
  final String buttonText;
  final bool alignToLeft;
  final Function onPressed;
  final double fontSize;
  final double minHeight;
  final bool isSelected;

  const CampeaoElevatedButton(
      {Key? key,
      required this.buttonText,
      required this.onPressed,
      this.alignToLeft = false,
      this.fontSize = 14,
      this.minHeight = 55,
      this.isSelected = false})
      : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        child: Align(
          alignment: _createAlignment(),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: fontSize),
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: isSelected ? CampeaoColors.primaryColorDark : CampeaoColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            )),
      ),
    );
  }

  Alignment _createAlignment() {
    return alignToLeft ? Alignment.centerLeft : Alignment.center;
  }
}
