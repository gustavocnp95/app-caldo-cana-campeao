import 'package:caldo_cana_campeao/color/theme_colors.dart';
import 'package:flutter/material.dart';

class UserListingItem extends StatelessWidget {
  final int userId;
  final String userName;
  final String userEmail;
  final bool isAdmin;

  const UserListingItem(
      {required this.userId,
      required this.userName,
      required this.userEmail,
      required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: ListTile(
            title: Text(userName),
            subtitle: Text(userEmail),
          ),
        ),
        Expanded(
          flex: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.edit),
                  color: CampeaoColors.primaryColor,
                  onPressed: () {}),
              IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.delete_forever_outlined),
                  color: CampeaoColors.primaryColor,
                  onPressed: () {}),
            ],
          ),
        ),
      ],
    );
  }
}
