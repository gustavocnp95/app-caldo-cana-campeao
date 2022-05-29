import 'package:caldo_cana_campeao/custom_widgets/campeao_app_bar.dart';
import 'package:flutter/material.dart';

class UserVisualizationEditionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserVisualizationEditionPageState();
}

class _UserVisualizationEditionPageState
    extends State<UserVisualizationEditionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CampeaoAppBar(),
    );
  }
}
