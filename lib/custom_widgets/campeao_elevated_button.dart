import 'package:flutter/material.dart';

import '../color/theme_colors.dart';

class CampeaoElevatedButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;

  const CampeaoElevatedButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 55),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        child: Text(buttonText),
        style: ElevatedButton.styleFrom(
            primary: CampeaoColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            )),
      ),
    );
  }
}
