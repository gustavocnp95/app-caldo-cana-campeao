import 'package:caldo_cana_campeao/custom_widgets/campeao_app_bar.dart';
import 'package:caldo_cana_campeao/login/login_page.dart';
import 'package:caldo_cana_campeao/user/infos/user_visualization_edition_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../color/theme_colors.dart';
import '../../commons/sharedpreferences/campeao_shared_preferences.dart';
import '../../custom_widgets/campeao_elevated_button.dart';
import '../infos/model/user_visualization_edition.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

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
            Padding(
              padding: const EdgeInsets.only(top: 34),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: Colors.black38,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: const CircleAvatar(
                    backgroundColor: CampeaoColors.primaryColorDark,
                    radius: 75,
                    child: Icon(
                      Icons.person_outline,
                      size: 125,
                      color: Colors.white,
                    ),
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
                child: _createOptions(context))
          ],
        ),
      ),
    );
  }

  ListView _createOptions(BuildContext context) {
    List<Widget> options = <Widget>[];
    options.add(
      _createOption("Alterar informações de cadastro", () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserVisualizationEditionPage(
              userVisualizationEdition: UserVisualizationEdition(
                  id: CampeaoSharedPreferences.getUserId() ?? 0,
                  name: CampeaoSharedPreferences.getUserName() ?? "",
                  email: CampeaoSharedPreferences.getUserEmail() ?? "",
                  isAdmin: CampeaoSharedPreferences.getUserIsAdmin() ?? false),
            ),
          ),
        );
      }),
    );
    if (CampeaoSharedPreferences.getUserIsAdmin() ?? false) {
      options.add(
        _createOption("Perfis cadastrados", () {}),
      );
    }
    options.add(
      _createOption("Sair da conta", () {
        _logout(context);
      }),
    );
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: options,
    );
  }

  void _logout(BuildContext context) {
    CampeaoSharedPreferences.clearLogonInfos();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        ModalRoute.withName('/login'));
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
