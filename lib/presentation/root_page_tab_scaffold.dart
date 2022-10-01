import 'package:curricuts/controller/menu_controller.dart';
import 'package:curricuts/presentation/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

class RootPageTabScaffold extends StatefulWidget {
  const RootPageTabScaffold({Key? key}) : super(key: key);

  @override
  State<RootPageTabScaffold> createState() => _RootPageTabScaffoldState();
}

class _RootPageTabScaffoldState extends State<RootPageTabScaffold>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabState = TabPage.of(context);
    final currentPath = Routemaster.of(context).currentRoute.fullPath;

    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: const SideMenu(),
      body: HeroControllerScope(
        controller: MaterialApp.createMaterialHeroController(),
        child: PageStackNavigator(
          key: ValueKey(currentPath),
          stack: tabState.stacks[tabState.index],
        ),
      ),
    );
  }
}
