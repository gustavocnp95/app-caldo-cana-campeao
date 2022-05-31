import 'package:caldo_cana_campeao/commons/sharedpreferences/campeao_shared_preferences.dart';
import 'package:caldo_cana_campeao/custom_widgets/campeao_app_bar.dart';
import 'package:caldo_cana_campeao/custom_widgets/campeao_text_field.dart';
import 'package:caldo_cana_campeao/user/infos/model/user_visualization_edition.dart';
import 'package:flutter/material.dart';

import '../../color/theme_colors.dart';
import '../../images/images.dart';

class UserVisualizationEditionPage extends StatefulWidget {
  final UserVisualizationEdition userVisualizationEdition;

  const UserVisualizationEditionPage(
      {Key? key, required this.userVisualizationEdition})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserVisualizationEditionPageState();
}

class _UserVisualizationEditionPageState
    extends State<UserVisualizationEditionPage> {
  bool _editMode = false;
  final String _editScreenTitle = "Editar cadastro";
  final String _visualizationScreenTitle = "Visualizar cadastro";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CampeaoAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
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
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _editMode
                            ? _editScreenTitle
                            : _visualizationScreenTitle,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: CampeaoColors.primaryTextColor,
                            fontSize: 25),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: _editMode ? createSaveIcon() : createEditIcon(),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: CampeaoInputTextField(
                  onTextChanged: (String newText) {
                    setState(() {
                      widget.userVisualizationEdition.name = newText;
                    });
                  },
                  enabled: _editMode,
                  hintText: "Nome",
                  initialText: widget.userVisualizationEdition.name,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: CampeaoInputTextField(
                  onTextChanged: (String newText) {
                    setState(() {
                      widget.userVisualizationEdition.email = newText;
                    });
                  },
                  enabled: _editMode,
                  hintText: "E-mail",
                  initialText: widget.userVisualizationEdition.email,
                ),
              ),
              Visibility(
                maintainSize: false,
                visible: CampeaoSharedPreferences.getUserIsAdmin() ?? false,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        checkColor: Colors.white,
                        value: widget.userVisualizationEdition.isAdmin,
                        activeColor: CampeaoColors.primaryColorDark,
                        onChanged: _editMode ? onCheckboxClicked : null,
                      ),
                      const Text(
                        "Usuário administrador",
                        style: TextStyle(fontSize: 17),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCheckboxClicked(bool? value) {
    setState(() {
      widget.userVisualizationEdition.isAdmin = value!;
    });
  }

  IconButton createEditIcon() {
    return IconButton(
      iconSize: 25,
      icon: const Icon(
        Icons.edit,
        color: CampeaoColors.primaryColor,
      ),
      onPressed: onEditButtonClick,
    );
  }

  IconButton createSaveIcon() {
    return IconButton(
      iconSize: 25,
      icon: const Icon(
        Icons.check,
        color: CampeaoColors.primaryColor,
      ),
      onPressed: onSaveButtonClick,
    );
  }

  void onEditButtonClick() {
    setState(() {
      _editMode = true;
    });
  }

  void onSaveButtonClick() {
    setState(() {
      _editMode = false;
    });
  }
}
