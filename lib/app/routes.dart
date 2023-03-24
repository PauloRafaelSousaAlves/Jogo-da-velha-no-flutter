import 'package:flutter/material.dart';
import 'package:tic_tac_toe/app/controller.dart';
import 'package:tic_tac_toe/app/unknow_view.dart';
import 'package:tic_tac_toe/presenter/game_screen/ui/game_screen.dart';

Widget initialPage(RouteSettings routeSettings, Controller controller) {
  Widget initialPage = GameScreenView();

  return initialPage;
}

Route<dynamic> routes(RouteSettings routeSettings, Controller controller) {
  Widget page = getPage(routeSettings, controller);
  switch (routeSettings.name) {
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (BuildContext context) {
            return page;
          });
  }
}

Widget getPage(RouteSettings routeSettings, Controller controller) {
  switch (routeSettings.name) {
    case '/':
      return initialPage(routeSettings, controller);
    case GameScreenView.routeName:
      return GameScreenView();
    default:
      return const AppUnknowView();
  }
}
