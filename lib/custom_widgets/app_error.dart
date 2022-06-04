import 'package:caldo_cana_campeao/images/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'campeao_elevated_button.dart';

class AppError extends StatelessWidget {
  final String? errorMessage;
  final String? errorSubmessage;
  final Function onActionBtnClick;
  final String? actionBtnTitle;
  final String defaultErrorMessage = "Aconteceu um problema!";

  const AppError(
      {Key? key,
      this.errorMessage,
      this.errorSubmessage,
      required this.onActionBtnClick,
      this.actionBtnTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorMessage ?? defaultErrorMessage,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
              ),
              Visibility(
                visible: true,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 16),
                  child: Text(
                    errorSubmessage ??
                        "Algo inesperado aconteceu. Não desanime, tente novamente.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 24),
                child: Image.asset(Images.errorImage),
              ),
              Container(
                padding: const EdgeInsets.only(top: 32),
                child: CampeaoElevatedButton(
                  onPressed: onActionBtnClick,
                  buttonText: actionBtnTitle ?? "Voltar",
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
