import 'package:caldo_cana_campeao/commons/sharedpreferences/campeao_shared_preferences.dart';
import 'package:caldo_cana_campeao/custom_widgets/app_loading.dart';
import 'package:caldo_cana_campeao/custom_widgets/campeao_logo.dart';
import 'package:caldo_cana_campeao/user/infos/model/user_visualization_edition.dart';
import 'package:caldo_cana_campeao/user/infos/user_visualization_edition_page.dart';
import 'package:caldo_cana_campeao/user/listing/user_listing_item.dart';
import 'package:caldo_cana_campeao/user/listing/user_listing_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/app_error.dart';
import '../../custom_widgets/campeao_app_bar.dart';

class UserListingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserListingPageState();
}

class _UserListingPageState extends State<UserListingPage> {
  UserListingPageViewModel? _viewModel;
  bool _shouldShowError = false;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<UserListingPageViewModel>(context, listen: false);
    Future.delayed(Duration.zero, () {
      _viewModel?.fetchUsers(() {}, () {
        setState(() {
          _shouldShowError = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<UserListingPageViewModel>();
    if (_shouldShowError) {
      return AppError(
        actionBtnTitle: "Tentar novamente",
        onActionBtnClick: () {
          setState(() {
            _shouldShowError = false;
            _viewModel?.fetchUsers(() {}, () {
              setState(() {
                _shouldShowError = true;
              });
            });
          });
        },
      );
    }
    if (_viewModel?.doingAsyncOperation ?? false) {
      return AppLoading();
    }
    return _createUi();
  }

  Scaffold _createUi() {
    return Scaffold(
      appBar: const CampeaoAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: CampeaoLogo(),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _viewModel?.users.length ?? 0,
                itemBuilder: (context, index) {
                  final user = _viewModel!.users[index];
                  return UserListingItem(
                    userId: user.id,
                    userName: user.name,
                    userEmail: user.email,
                    isAdmin: user.isAdmin,
                    onEditUserClick: onEditItemClick,
                    onDeleteUserClick: onDeleteItemClick,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onEditItemClick(
    int userId,
    String userName,
    String userEmail,
    bool isAdmin,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => UserVisualizationEditionPage(
                userVisualizationEdition: UserVisualizationEdition(
                  id: userId,
                  name: userName,
                  email: userEmail,
                  isAdmin: isAdmin,
                ),
              )),
    );
    _viewModel?.fetchUsers(() {}, () {});
  }

  onDeleteItemClick(int userId) {
    final int loggedUserId = CampeaoSharedPreferences.getUserId() ?? 0;
    if (userId != loggedUserId) {
      _viewModel?.deleteUser(userId, () {
        Fluttertoast.showToast(msg: "Usuário deletado com sucesso!");
      }, () {
        Fluttertoast.showToast(msg: "Falha ao deletar o usuário!");
      });
    } else {
      Fluttertoast.showToast(
          msg: "Não é possível excluir seu próprio usuário.");
    }
  }
}
