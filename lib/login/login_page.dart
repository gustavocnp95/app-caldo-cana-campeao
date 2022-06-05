import 'package:caldo_cana_campeao/color/theme_colors.dart';
import 'package:caldo_cana_campeao/login/login_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../custom_widgets/app_error.dart';
import '../custom_widgets/app_loading.dart';
import '../custom_widgets/campeao_elevated_button.dart';
import '../custom_widgets/campeao_text_field.dart';
import '../images/images.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String emailInput = "";
  String passwordInput = "";
  LoginPageViewModel? viewModel;

  @override
  Widget build(final BuildContext context) {
    viewModel = context.watch<LoginPageViewModel>();
    return _createUi(context);
  }

  Widget _createUi(BuildContext context) {
    if (viewModel?.doingAsyncOperation ?? false) {
      return AppLoading();
    }
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 48),
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
                radius: 120,
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
          const Padding(
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 32, top: 56),
            child: Text(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: CampeaoColors.primaryTextColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: CampeaoInputTextField(
              onTextChanged: onEmailTextChanged,
              hintText: 'E-mail',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 24),
            child: CampeaoInputTextField(
              onTextChanged: onPasswordTextChanged,
              hintText: 'Password',
              hidePasswordEnabled: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 32),
            child: CampeaoElevatedButton(
              buttonText: 'Entrar',
              onPressed: () {
                viewModel?.doLogin(
                    emailInput.trim(),
                    passwordInput.trim(),
                    () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                        ModalRoute.withName('/home')),
                    _onLoginError);
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onEmailTextChanged(String newText) {
    emailInput = newText;
  }

  void onPasswordTextChanged(String newText) {
    passwordInput = newText;
  }

  void _onLoginError() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Atenção'),
            content: const Text('Usuário ou senha incorretos.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _dismissDialog();
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

  _dismissDialog() {
    Navigator.pop(context);
  }
}
