import 'package:curricuts/core/consts/app.dart';
import 'package:curricuts/core/consts/home/home.dart';
import 'package:curricuts/core/consts/subjects/subjects.dart';
import 'package:flutter/material.dart';
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
      appBar: _buildAppBar(context, currentPath),
      body: HeroControllerScope(
        controller: MaterialApp.createMaterialHeroController(),
        child: PageStackNavigator(
          key: ValueKey(currentPath),
          stack: tabState.stacks[tabState.index],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200]!,
              blurRadius: 8,
              spreadRadius: 8,
            ),
          ],
        ),
        child: SizeTransition(
          sizeFactor: _animationController,
          axisAlignment: -1,
          child: BottomNavigationBar(
            onTap: (value) => tabState.controller.animateTo(value),
            currentIndex: tabState.index,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: HomeConsts.title,
                backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.lightbulb_outline),
                label: SubjectsConst.title,
                backgroundColor: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, String currentPath) {
    return AppBar(
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.account_circle),
        ),
      ),
      title: const Text(AppConsts.appName),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.phone_outlined),
            label: const Text('Placeholder'),
          ),
        ),
      ],
    );
  }
}
