import 'package:caldo_cana_campeao/color/theme_colors.dart';
import 'package:flutter/material.dart';

class CampeaoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CampeaoAppBar({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: EdgeInsets.all(11),
          child: FloatingActionButton(
        onPressed: () {},
            backgroundColor: CampeaoColors.primaryColor,
        child: Icon(Icons.arrow_back),
      )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
