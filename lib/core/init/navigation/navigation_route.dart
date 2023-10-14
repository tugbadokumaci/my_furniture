import 'package:flutter/material.dart';
import 'package:my_furniture/core/components/not_found_navigation_widget.dart';
import 'package:my_furniture/core/constants/navigation/navigation_constants.dart';

import '../../../view/category/view/category_view.dart';
import '../../../view/home/view/home_view.dart';
import '../../../view/login/view/login_view.dart';
import '../../../view/search/view/search_view.dart';

class NavigationRoute {
  static NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationConstants.HOME_VIEW:
        return normalNavigate(HomeView());
      case NavigationConstants.SEARCH_VIEW:
        return normalNavigate(SearchView());
      case NavigationConstants.LOGIN_VIEW:
        return normalNavigate(LoginView());
      case NavigationConstants.CATEGORY_VIEW:
        return normalNavigate(CategoryView(
          categoryName: settings.arguments.toString(),
        ));
      default:
        return MaterialPageRoute(builder: (context) => const NotFoundNavigation());
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }
}
