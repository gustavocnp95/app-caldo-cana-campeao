import 'package:caldo_cana_campeao/custom_widgets/campeao_app_bar.dart';
import 'package:caldo_cana_campeao/custom_widgets/campeao_text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../color/theme_colors.dart';
import '../../images/images.dart';

class UserVisualizationEditionPage extends StatefulWidget {
  const UserVisualizationEditionPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserVisualizationEditionPageState();
}

class _UserVisualizationEditionPageState
    extends State<UserVisualizationEditionPage> {
  String _screenTitle = "Visualizar cadastro";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CampeaoAppBar(),
      body: Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 56, bottom: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _screenTitle,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: CampeaoColors.primaryTextColor,
                      fontSize: 25),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: CampeaoInputTextField(
                onTextChanged: (String newText) {},
                enabled: false,
                initialText: "teste",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: CampeaoInputTextField(
                onTextChanged: (String newText) {},
                enabled: false,
                initialText: "teste",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
