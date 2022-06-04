import 'package:caldo_cana_campeao/color/theme_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(
          color: CampeaoColors.primaryColorDark,
          strokeWidth: 5,
        ),
      ),
    ));
  }
}
