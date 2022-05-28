import 'package:caldo_cana_campeao/custom_widgets/campeao_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserMenuPage extends StatelessWidget {
  const UserMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CampeaoAppBar(),
      body: Text("User Menu")
    );
  }
}
