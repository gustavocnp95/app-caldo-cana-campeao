import 'package:caldo_cana_campeao/custom_widgets/campeao_elevated_button.dart';
import 'package:caldo_cana_campeao/custom_widgets/campeao_logo.dart';
import 'package:caldo_cana_campeao/user/register/model/user_registration.dart';
import 'package:flutter/material.dart';

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
  bool _shouldShowError = false;
  bool _shouldShowPasswordConfirmationError = false;
  bool _shouldShowNameError = false;
  bool _shouldShowEmailError = false;

  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.only(bottom: 24),
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
}
