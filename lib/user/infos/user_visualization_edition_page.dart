import 'package:caldo_cana_campeao/commons/sharedpreferences/campeao_shared_preferences.dart';
import 'package:caldo_cana_campeao/custom_widgets/app_error.dart';
import 'package:caldo_cana_campeao/custom_widgets/app_loading.dart';
import 'package:caldo_cana_campeao/custom_widgets/campeao_app_bar.dart';
import 'package:caldo_cana_campeao/custom_widgets/campeao_logo.dart';
import 'package:caldo_cana_campeao/custom_widgets/campeao_text_field.dart';
import 'package:caldo_cana_campeao/user/infos/model/user_visualization_edition.dart';
import 'package:caldo_cana_campeao/user/infos/user_visualization_edition_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../color/theme_colors.dart';
import '../../login/login_page.dart';

class UserVisualizationEditionPage extends StatefulWidget {
  final UserVisualizationEdition userVisualizationEdition;

  const UserVisualizationEditionPage(
      {required this.userVisualizationEdition})
      : super();

  @override
  State<StatefulWidget> createState() => _UserVisualizationEditionPageState();
}

class _UserVisualizationEditionPageState
    extends State<UserVisualizationEditionPage> {
  UserVisualizationEditionPageViewModel? _viewModel;
  bool _editMode = false;
  bool _shouldShowError = false;
  final String _editScreenTitle = "Editar cadastro";
  final String _visualizationScreenTitle = "Visualizar cadastro";
  bool _shouldShowPasswordConfirmationError = false;
  bool _shouldShowNameError = false;
  bool _shouldShowEmailError = false;

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<UserVisualizationEditionPageViewModel>();
    return _createUi();
  }

  Widget _createUi() {
    if (_shouldShowError) {
      return AppError(
        onActionBtnClick: () {
          setState(() {
            _shouldShowError = false;
          });
        },
      );
    }
    if (_viewModel?.doingAsyncOperation ?? false) {
      return AppLoading();
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CampeaoAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: CampeaoLogo(),
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
                      _shouldShowNameError =
                          !widget.userVisualizationEdition.isNameValid();
                    });
                  },
                  enabled: _editMode,
                  hintText: "Nome",
                  initialText: widget.userVisualizationEdition.name,
                  errorActivated: _shouldShowNameError,
                  errorText: "O nome não pode ser branco",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: CampeaoInputTextField(
                  onTextChanged: (String newText) {
                    setState(() {
                      widget.userVisualizationEdition.email = newText;
                      _shouldShowEmailError =
                          !widget.userVisualizationEdition.isEmailValid();
                    });
                  },
                  enabled: _editMode,
                  hintText: "E-mail",
                  initialText: widget.userVisualizationEdition.email,
                  errorActivated: _shouldShowEmailError,
                  errorText: "O e-mail não pode ser branco",
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
              ExpansionTile(
                iconColor: CampeaoColors.primaryColor,
                textColor: CampeaoColors.primaryColor,
                initiallyExpanded:
                    widget.userVisualizationEdition.isNewPasswordFilled(),
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                title: const Text('Senha'),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: CampeaoInputTextField(
                      hidePasswordEnabled: true,
                      onTextChanged: (String newText) {
                        setState(() {
                          widget.userVisualizationEdition.newPassword = newText;
                          _shouldShowPasswordConfirmationError = !widget
                              .userVisualizationEdition
                              .isNewPasswordValid();
                        });
                      },
                      enabled: _editMode,
                      hintText: "Nova senha",
                      initialText: widget.userVisualizationEdition.newPassword,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: CampeaoInputTextField(
                      hidePasswordEnabled: true,
                      errorText: "As senhas não conferem",
                      errorActivated: _shouldShowPasswordConfirmationError,
                      onTextChanged: (String newText) {
                        setState(() {
                          widget.userVisualizationEdition
                              .newPasswordConfirmation = newText;
                          _shouldShowPasswordConfirmationError = !widget
                              .userVisualizationEdition
                              .isNewPasswordValid();
                        });
                      },
                      enabled: _editMode,
                      hintText: "Confirmação nova senha",
                      initialText: widget
                          .userVisualizationEdition.newPasswordConfirmation,
                    ),
                  ),
                ],
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
    if (widget.userVisualizationEdition.isFieldsValid()) {
      _viewModel?.updateUser(
        widget.userVisualizationEdition.id,
        widget.userVisualizationEdition.email,
        widget.userVisualizationEdition.name,
        widget.userVisualizationEdition.newPassword,
        widget.userVisualizationEdition.isAdmin,
        _onSaveEmployeeSuccess,
        _onSaveEmployeeError,
      );
    } else {
      _showInvalidInfosDialog();
    }
  }

  void _showInvalidInfosDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Atenção'),
            content: const Text(
                'Algum campo não está preenchido corretamente. Por favor, revise.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: 15,
                    color: CampeaoColors.primaryColorDark,
                  ),
                ),
              )
            ],
          );
        });
  }

  void _onSaveEmployeeError() {
    setState(() {
      _shouldShowError = true;
    });
  }

  void _onSaveEmployeeSuccess() {
    setState(() {
      _editMode = false;
      widget.userVisualizationEdition.newPassword = null;
      widget.userVisualizationEdition.newPasswordConfirmation = null;
    });
    if (widget.userVisualizationEdition.id ==
        CampeaoSharedPreferences.getUserId()) {
      _showLogoutDialog(context);
    } else {
      _showSuccessDialog();
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Sucesso'),
            content: const Text(
                'Você será deslogado para atualizar as informações de cadastro no aparelho.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _logout(context);
                },
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: 15,
                    color: CampeaoColors.primaryColorDark,
                  ),
                ),
              )
            ],
          );
        });
  }

  void _logout(BuildContext context) {
    CampeaoSharedPreferences.clearLogonInfos();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        ModalRoute.withName('/login'));
  }

  void _showSuccessDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Sucesso'),
            content: const Text('Informações atualizadas!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: 15,
                    color: CampeaoColors.primaryColorDark,
                  ),
                ),
              )
            ],
          );
        });
  }
}
