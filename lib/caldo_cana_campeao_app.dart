import 'package:caldo_cana_campeao/login_page.dart';
import 'package:flutter/material.dart';

class CaldoCanaCampeaoApp extends StatelessWidget {
  const CaldoCanaCampeaoApp({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}