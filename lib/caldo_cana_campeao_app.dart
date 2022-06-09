import 'package:caldo_cana_campeao/commons/sharedpreferences/campeao_shared_preferences.dart';
import 'package:caldo_cana_campeao/login/login_page.dart';
import 'package:caldo_cana_campeao/login/login_page_view_model.dart';
import 'package:caldo_cana_campeao/home/home_page.dart';
import 'package:caldo_cana_campeao/user/infos/user_visualization_edition_page_view_model.dart';
import 'package:caldo_cana_campeao/user/listing/user_listing_page_view_model.dart';
import 'package:caldo_cana_campeao/user/menu/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'commons/network/network_constants.dart';

class CaldoCanaCampeaoApp extends StatelessWidget {
  const CaldoCanaCampeaoApp({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    String? userToken = CampeaoSharedPreferences.getUserToken();
    if (userToken != null) {
      CampeaoNetworkConstants.addAuthorizationHeader(userToken);
    }
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LoginPageViewModel()),
          ChangeNotifierProvider(
              create: (_) => UserVisualizationEditionPageViewModel()),
          ChangeNotifierProvider(create: (_) => UserListingPageViewModel())
        ],
        child: MaterialApp(
          home: userToken != null ? const HomePage() : LoginPage(),
          routes: <String, WidgetBuilder>{
            '/login': (BuildContext context) => LoginPage(),
            '/home': (BuildContext context) => HomePage(),
            '/user/menu': (BuildContext context) => MenuPage(),
          },
        ));
  }
}
