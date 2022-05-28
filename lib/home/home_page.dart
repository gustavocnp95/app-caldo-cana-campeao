import 'package:caldo_cana_campeao/color/theme_colors.dart';
import 'package:caldo_cana_campeao/commons/icons/campeao_icons_icons.dart';
import 'package:caldo_cana_campeao/commons/sharedpreferences/campeao_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
          _createHeader(),
          _createReportAbstract(),
          _createMenuOptions(),
        ]),
      ),
    );
  }

  Padding _createReportAbstract() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 40),
      child: Card(
        elevation: 5,
        color: CampeaoColors.primaryBackgroundColorSoft,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: CampeaoColors.primaryColorDark),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 16, bottom: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _createTitleLabel(),
                _createAmountLabel(),
              ]),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _createForwardButton(),
                      ]),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Padding _createMenuOptions() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 40),
      child: GridView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 55,
            mainAxisSpacing: 32,
            childAspectRatio: 1.5),
        children: _createOptionsList(),
      ),
    );
  }

  List<Widget> _createOptionsList() {
    List<Widget> options = <Widget>[];
    options.add(_createOption("Ordem de Compra", () {
      Fluttertoast.showToast(msg: "soon, very soon!");
    }));
    options.add(_createOption("Novo Pedido", () {
      Fluttertoast.showToast(msg: "soon, very soon!");
    }));
    options.add(_createOption("Relatórios", () {
      Fluttertoast.showToast(msg: "soon, very soon!");
    }));
    if (CampeaoSharedPreferences.getUserIsAdmin() ?? false) {
      options.add(_createOption("Produtos", () {
        Fluttertoast.showToast(msg: "soon, very soon!");
      }));
    }
    return options;
  }

  InkWell _createOption(String title, Function action) {
    return InkWell(
      onTap: () {
        action();
      },
      child: Card(
        elevation: 5,
        color: CampeaoColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Text _createTitleLabel() {
    return const Text(
      "Entrada",
      style: TextStyle(
          color: CampeaoColors.primaryColorDark,
          fontWeight: FontWeight.w500,
          fontSize: 18),
    );
  }

  Padding _createAmountLabel() {
    return const Padding(
      padding: EdgeInsets.only(top: 16),
      child: Text(
        "R\$ 50,00",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
    );
  }

  FloatingActionButton _createForwardButton() {
    return FloatingActionButton.small(
      onPressed: () {},
      backgroundColor: CampeaoColors.primaryColor,
      child: const Icon(Icons.arrow_forward),
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
          fontWeight: FontWeight.w700,
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

  InkWell _createAvatar() {
    return InkWell(
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
