import 'package:curricuts/core/consts/app.dart';
import 'package:curricuts/core/theme/app.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabState = TabPage.of(context);
    return Drawer(
      backgroundColor: AppColors.primaryColor,
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text(
              AppConsts.appName,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          _DrawerListTile(
            title: AppConsts.dashboard,
            press: () {
              tabState.controller.animateTo(0);
            },
            icon: const Icon(
              Icons.dashboard_rounded,
              color: Colors.white,
            ),
          ),
          _DrawerListTile(
            title: AppConsts.subjects,
            press: () {
              tabState.controller.animateTo(1);
            },
            icon: const Icon(
              Icons.menu_book_outlined,
              color: Colors.white,
            ),
          ),
          _DrawerListTile(
            title: AppConsts.about,
            press: () {
              tabState.controller.animateTo(1);
            },
            icon: const Icon(
              Icons.info,
              color: Colors.white,
            ),
          ),
          _DrawerListTile(
            title: AppConsts.profile,
            press: () {},
            icon: const Icon(
              Icons.account_box,
              color: Colors.white,
            ),
          ),
          _DrawerListTile(
            title: AppConsts.settings,
            press: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerListTile extends StatelessWidget {
  const _DrawerListTile({
    Key? key,
    required this.title,
    required this.press,
    this.icon,
  }) : super(key: key);

  final String title;
  final Icon? icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: icon,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
