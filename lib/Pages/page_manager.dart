import 'package:exye_app/Pages/Content/p00_landing.dart';
import 'package:exye_app/Pages/Content/p04_home.dart';
import 'package:exye_app/Pages/page_route.dart';
import 'package:flutter/cupertino.dart';

class PageManager {
  GlobalKey<NavigatorState> pageNav = GlobalKey();
  Navigator? pageNavObj;

  void initialise (String state) {
    pageNavObj ??= Navigator(
      key: pageNav,
      initialRoute: "/" + state,
      onGenerateInitialRoutes: (NavigatorState nav, String initRoute) {
        return [nav.widget.onGenerateRoute!(RouteSettings(name: "/" + state))!];
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case "/login":
            return CustomPageRoute(LandingPage());
          case "/home":
            return CustomPageRoute(const HomePage());
          default:
            return CustomPageRoute(LandingPage());
        }
      },
    );
  }

  void nextPage (Widget page) {
    pageNav.currentState!.push(
      CustomPageRoute(page),
    );
  }

  void prevPage () {
    pageNav.currentState!.pop();
  }

  void newPage (Widget page) {
    pageNav.currentState!.pushAndRemoveUntil(
      CustomPageRoute(page),
      (Route<dynamic> route) => false,
    );
  }
}