import 'package:caldo_cana_campeao/caldo_cana_campeao_app.dart';
import 'package:caldo_cana_campeao/commons/sharedpreferences/campeao_shared_preferences.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CampeaoSharedPreferences.getInstance();
  return runApp(const CaldoCanaCampeaoApp());
}
