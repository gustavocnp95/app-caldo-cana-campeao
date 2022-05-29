import 'package:caldo_cana_campeao/commons/sharedpreferences/campeao_shared_preferences.dart';
import 'package:caldo_cana_campeao/login/login_page.dart';
import 'package:caldo_cana_campeao/login/login_page_view_model.dart';
import 'package:caldo_cana_campeao/home/home_page.dart';
import 'package:caldo_cana_campeao/user/infos/user_visualization_edition_page.dart';
import 'package:caldo_cana_campeao/user/menu/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CaldoCanaCampeaoApp extends StatelessWidget {
  const CaldoCanaCampeaoApp({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginPageViewModel()),
        ],
        child: MaterialApp(
          home: CampeaoSharedPreferences.getUserToken() != null
              ? const HomePage()
              : LoginPage(),
          routes: <String, WidgetBuilder>{
            '/login': (BuildContext context) => LoginPage(),
            '/home': (BuildContext context) => HomePage(),
            '/user/menu': (BuildContext context) => MenuPage(),
            '/user/infos': (BuildContext context) => UserVisualizationEditionPage()
          },
        ));
  }
}
