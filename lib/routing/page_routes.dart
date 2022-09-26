import 'package:curricuts/presentation/pages/home/home.dart';
import 'package:curricuts/presentation/pages/loading.dart';
import 'package:curricuts/presentation/pages/subjects/subjects.dart';
import 'package:curricuts/presentation/root_page_tab_scaffold.dart';
import 'package:curricuts/routing/routes.dart';
import 'package:routemaster/routemaster.dart';

class PageRoutes {
  static final loading = RouteMap(
    routes: {
      Routes.loading: (_) => LoadingPage(),
    },
    onUnknownRoute: (_) => const Redirect(Routes.loading),
  );

  static final home = RouteMap(
    routes: {
      // `/`
      // Be mindful of ordering, must match expected bottom nav order
      Routes.root: (routeData) => const TabPage(
            child: RootPageTabScaffold(),
            paths: [
              Routes.home,
              Routes.subjects,
            ],
          ),

      /// **********************************************************************
      /// home
      /// **********************************************************************
      // `/home`
      Routes.home: (_) => HomePage(),

      /// **********************************************************************
      /// subjects
      /// **********************************************************************
      // `/subjects`
      Routes.subjects: (_) => SubjectsPage(),
    },
  );
}
