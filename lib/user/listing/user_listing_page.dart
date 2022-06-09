import 'package:caldo_cana_campeao/user/listing/user_listing_item.dart';
import 'package:flutter/material.dart';

import '../../custom_widgets/campeao_app_bar.dart';

class UserListingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserListingPageState();
}

class _UserListingPageState extends State<UserListingPage> {
  List<Teste> pessoas = [];

  @override
  void initState() {
    super.initState();
    pessoas.add(Teste("Gustavo Navarro", "gustavocnavarro@gmail.com"));
    pessoas.add(Teste("Roney Pires", "roneynpires@hotmail.com"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CampeaoAppBar(),
      body: SingleChildScrollView(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: pessoas.length,
          itemBuilder: (context, index) {
            final pessoa = pessoas[index];
            return UserListingItem(
                userId: 1,
                userName: pessoa.nome,
                userEmail: pessoa.email,
                isAdmin: true);
          },
        ),
      ),
    );
  }
}

class Teste {
  final String nome;
  final String email;

  Teste(this.nome, this.email);
}
