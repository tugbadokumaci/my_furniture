import 'package:flutter/material.dart';
import 'package:my_furniture/core/init/navigation/i_navigation_service.dart';

class NavigationService implements INavigationService {
  static NavigationService _instance = NavigationService._init();
  static NavigationService get instance => _instance;

  NavigationService._init();

  // bütün navigation işlemlerini bu sınıf üzerinden yapacağız.
  // bu sınıfı kullanabilmek için navigatorKey'i MaterialApp içerisinde tanımlamamız gerekiyor.
  // bütün navigation yönetebileceğiniz key oluşturuyor.Ve bunu state sakliyoruz.

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  final removeAllOldRoutes = (Route<dynamic> route) => false;
  @override
  Future<void> navigateToPage(String path, Object data) async {
    await navigatorKey.currentState!.pushNamed(path, arguments: data);
  }

  @override
  Future<void> navigateToPageClear(String path, Object data) async {
    await navigatorKey.currentState!.pushNamedAndRemoveUntil(path, removeAllOldRoutes, arguments: data);
  }
}
