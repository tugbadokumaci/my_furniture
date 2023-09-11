import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_furniture/core/constants/app/app_constants.dart';
import 'package:my_furniture/core/constants/navigation/navigation_constants.dart';
import 'package:my_furniture/core/init/cache/locale_manager.dart';
import 'package:my_furniture/core/init/lang/language_manager.dart';
import 'package:my_furniture/core/init/navigation/navigation_route.dart';
import 'package:my_furniture/core/init/navigation/navigation_serice.dart';

void main() {
  LocaleManager.preferencesInit();
  runApp(EasyLocalization(
      supportedLocales: LanguageManager.instance.supportedLocales,
      path: ApplicationConstants.LANG_ASSET_PATH,
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: NavigationConstants.HOME_VIEW,
      onGenerateRoute: NavigationRoute.instance.onGenerateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}
