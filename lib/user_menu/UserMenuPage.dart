import 'package:caldo_cana_campeao/custom_widgets/campeao_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../color/theme_colors.dart';
import '../commons/sharedpreferences/campeao_shared_preferences.dart';
import '../custom_widgets/campeao_elevated_button.dart';

class UserMenuPage extends StatelessWidget {
  const UserMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CampeaoAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(right: 8, left: 8, top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Perfil",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 34),
              child: Align(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  backgroundColor: CampeaoColors.primaryColorDark,
                  radius: 60,
                  child: Icon(
                    Icons.person_outline,
                    size: 95,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Align(
                alignment: Alignment.center,
                child: _createUserWelcome(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48),
              child: _createOptions(),
            )
          ],
        ),
      ),
    );
  }

  ListView _createOptions() {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        _createOption("Alterar senha", () {}),
        _createOption("Perfis cadastrados", () {}),
        _createOption("Sair do aplicativo", () {}),
      ],
    );
  }

  Padding _createOption(String title, Function onPressed) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: CampeaoElevatedButton(
          buttonText: title,
          onPressed: onPressed,
          alignToLeft: true,
          fontSize: 18,
        ));
  }

  Text _createUserWelcome() {
    final String userName = CampeaoSharedPreferences.getUserName() ?? "";
    return Text(
      'Olá, $userName!',
      style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: CampeaoColors.primaryTextColor,
          fontSize: 25),
    );
  }
}
