import 'package:caldo_cana_campeao/color/theme_colors.dart';
import 'package:caldo_cana_campeao/commons/icons/campeao_icons_icons.dart';
import 'package:caldo_cana_campeao/commons/sharedpreferences/campeao_shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Fluttertoast.showToast(msg: CampeaoSharedPreferences.getUserEmail() ?? "ruim");
    return Scaffold(
      body: Center(
        child: ListView(children: <Widget>[
          _createHeader(),
        ]),
      ),
    );
  }

  Padding _createHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 40, right: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _createAvatar(),
                ),
              ),
              _createHideAmountButton(),
              _createAddUserButton(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: _createUserWelcome(),
            ),
          )
        ],
      ),
    );
  }

  Text _createUserWelcome() {
    return const Text(
      'Olá, Julio!',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: CampeaoColors.primaryTextColor,
          fontSize: 25),
    );
  }

  IconButton _createAddUserButton() {
    return IconButton(
      iconSize: 25,
      icon: const Icon(
        CampeaoIcons.user_add_outline,
        color: CampeaoColors.primaryColor,
      ),
      onPressed: () {},
    );
  }

  IconButton _createHideAmountButton() {
    return IconButton(
      iconSize: 30,
      icon: const Icon(
        Icons.remove_red_eye_outlined,
        color: CampeaoColors.primaryColor,
      ),
      onPressed: () {},
    );
  }

  GestureDetector _createAvatar() {
    return GestureDetector(
      onTap: () {},
      child: const CircleAvatar(
        backgroundColor: CampeaoColors.primaryColor,
        radius: 60,
        child: Icon(
          Icons.person_outline,
          size: 95,
          color: Colors.white,
        ),
      ),
    );
  }
}
