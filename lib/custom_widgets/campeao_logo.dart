import 'package:flutter/material.dart';

import '../color/theme_colors.dart';
import '../images/images.dart';

class CampeaoLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black38,
            spreadRadius: 1,
          )
        ],
      ),
      child: CircleAvatar(
        backgroundColor: CampeaoColors.primaryColor,
        radius: 100,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: ClipRRect(
            child: Image.asset(Images.caldoCanaCampeaoLogo),
            borderRadius: BorderRadius.circular(1000),
          ),
        ),
      ),
    );
  }
}
