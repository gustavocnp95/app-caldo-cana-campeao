import 'package:caldo_cana_campeao/custom_widgets/app_error.dart';
import 'package:caldo_cana_campeao/custom_widgets/app_loading.dart';
import 'package:caldo_cana_campeao/custom_widgets/campeao_elevated_button.dart';
import 'package:caldo_cana_campeao/custom_widgets/campeao_logo.dart';
import 'package:caldo_cana_campeao/user/register/model/user_registration.dart';
import 'package:caldo_cana_campeao/user/register/user_register_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../color/theme_colors.dart';
import '../../commons/sharedpreferences/campeao_shared_preferences.dart';
import '../../custom_widgets/campeao_app_bar.dart';
import '../../custom_widgets/campeao_text_field.dart';

class UserRegisterPage extends StatefulWidget {
  UserRegisterPage({Key? key}) : super(key: key);
  final UserRegistration userRegistrationEdition = UserRegistration();

  @override
  State<StatefulWidget> createState() => UserRegisterPageState();
}

class UserRegisterPageState extends State<UserRegisterPage> {
  UserRegisterPageViewModel? viewModel;
  bool _shouldShowError = false;
  bool _shouldShowPasswordConfirmationError = false;
  bool _shouldShowNameError = false;
  bool _shouldShowEmailError = false;

  @override
  Widget build(BuildContext context) {
    viewModel = context.watch<UserRegisterPageViewModel>();

    if (_shouldShowError) {
      return AppError(
        onActionBtnClick: () {
          setState(() {
            _shouldShowError = false;
          });
        },
        actionBtnTitle: "Voltar",
      );
    }
    if (viewModel?.doingAsyncOperation ?? false) {
      return AppLoading();
    }
    return _createUi();
  }

  Scaffold _createUi() {
    return Scaffold(
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
                padding: const EdgeInsets.only(bottom: 24, top: 24),
                child: CampeaoInputTextField(
                  onTextChanged: (String newText) {
                    setState(() {
                      widget.userRegistrationEdition.name = newText;
                      _shouldShowNameError =
                          !widget.userRegistrationEdition.isNameValid();
                    });
                  },
                  hintText: "Nome",
                  initialText: widget.userRegistrationEdition.name,
                  errorActivated: _shouldShowNameError,
                  errorText: "O nome não pode ser branco",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: CampeaoInputTextField(
                  onTextChanged: (String newText) {
                    setState(() {
                      widget.userRegistrationEdition.email = newText;
                      _shouldShowEmailError =
                          !widget.userRegistrationEdition.isEmailValid();
                    });
                  },
                  hintText: "E-mail",
                  initialText: widget.userRegistrationEdition.email,
                  errorActivated: _shouldShowEmailError,
                  errorText: "O e-mail não pode ser branco",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: CampeaoInputTextField(
                  hidePasswordEnabled: true,
                  onTextChanged: (String newText) {
                    setState(() {
                      widget.userRegistrationEdition.newPassword = newText;
                      _shouldShowPasswordConfirmationError =
                          !widget.userRegistrationEdition.isNewPasswordValid();
                    });
                  },
                  hintText: "Nova senha",
                  initialText: widget.userRegistrationEdition.newPassword,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: CampeaoInputTextField(
                  hidePasswordEnabled: true,
                  errorText:
                      widget.userRegistrationEdition.bothPasswordFieldsEmpty()
                          ? "A senha não pode ser em branco"
                          : "As senhas não conferem",
                  errorActivated: _shouldShowPasswordConfirmationError,
                  onTextChanged: (String newText) {
                    setState(() {
                      widget.userRegistrationEdition.newPasswordConfirmation =
                          newText;
                      _shouldShowPasswordConfirmationError =
                          !widget.userRegistrationEdition.isNewPasswordValid();
                    });
                  },
                  hintText: "Confirmação nova senha",
                  initialText:
                      widget.userRegistrationEdition.newPasswordConfirmation,
                ),
              ),
              Visibility(
                maintainSize: false,
                visible: CampeaoSharedPreferences.getUserIsAdmin() ?? false,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          checkColor: Colors.white,
                          value: widget.userRegistrationEdition.isAdmin,
                          activeColor: CampeaoColors.primaryColorDark,
                          onChanged: onCheckboxClicked,
                        ),
                        const Text(
                          "Usuário administrador",
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              CampeaoElevatedButton(
                  buttonText: "Criar usuário",
                  onPressed: () {
                    validateFields();
                    if (widget.userRegistrationEdition.isFieldsValid()) {
                      viewModel?.createUser(
                          widget.userRegistrationEdition.name!,
                          widget.userRegistrationEdition.email!,
                          widget.userRegistrationEdition.newPassword!,
                          widget.userRegistrationEdition.isAdmin,
                          onCreateUserSuccess,
                          onCreateUserError);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  void onCheckboxClicked(bool? value) {
    setState(() {
      widget.userRegistrationEdition.isAdmin = value!;
    });
  }

  void validateFields() {
    setState(() {
      _shouldShowEmailError = !widget.userRegistrationEdition.isEmailValid();
      _shouldShowNameError = !widget.userRegistrationEdition.isNameValid();
      _shouldShowPasswordConfirmationError =
          !widget.userRegistrationEdition.isNewPasswordValid();
    });
  }
  
  Future<void> onCreateUserSuccess() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Sucesso'),
            content: const Text('Usuário criado!'),
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
    Navigator.pop(context);
  }

  void onCreateUserError() {
    setState(() {
      _shouldShowError = true;
    });
  }
}
