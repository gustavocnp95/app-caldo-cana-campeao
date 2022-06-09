import 'package:caldo_cana_campeao/user/listing/user_listing_item.dart';
import 'package:caldo_cana_campeao/user/listing/user_listing_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../color/theme_colors.dart';
import '../../custom_widgets/campeao_app_bar.dart';
import '../../images/images.dart';

class UserListingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserListingPageState();
}

class _UserListingPageState extends State<UserListingPage> {
  UserListingPageViewModel? _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<UserListingPageViewModel>(context, listen: false);
    Future.delayed(Duration.zero,() {
      _viewModel?.fetchUsers(() {}, () {});
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<UserListingPageViewModel>();
    return Scaffold(
      appBar: const CampeaoAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
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
                  radius: 100,
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
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _viewModel?.users.length ?? 0,
                itemBuilder: (context, index) {
                  final user = _viewModel!.users[index];
                  return UserListingItem(
                      userId: 1,
                      userName: user.name,
                      userEmail: user.email,
                      isAdmin: true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
