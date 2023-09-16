import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_furniture/core/components/decoration/circle_decoration.dart';
import 'package:my_furniture/core/constants/app/app_constants.dart';
import 'package:my_furniture/core/constants/navigation/navigation_constants.dart';
import 'package:my_furniture/core/init/cache/locale_manager.dart';
import 'package:my_furniture/core/init/lang/language_manager.dart';
import 'package:my_furniture/core/init/navigation/navigation_route.dart';
import 'package:my_furniture/core/init/navigation/navigation_serice.dart';
import 'package:my_furniture/core/init/theme/light/color_scheme_light.dart';
import 'package:my_furniture/view/furniture_tab_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  LocaleManager.preferencesInit();
  runApp(EasyLocalization(
      supportedLocales: LanguageManager.instance.supportedLocales,
      path: ApplicationConstants.LANG_ASSET_PATH,
      // fallbackLocale: Localization.SUPPORTED_LANGUAGES[0],
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
      home: const FurnitureTabView(),
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(color: Colors.transparent, elevation: 0),
        tabBarTheme: TabBarTheme(
            labelColor: ColorSchemeLight.instance.orange,
            unselectedLabelColor: ColorSchemeLight.instance.darkGray,
            indicatorSize: TabBarIndicatorSize.label,
            // indicator: BoxDecoration(
            //   borderRadius: BorderRadius.circular(50),
            //   color: Colors.grey.shade200,
            // ),
            indicator: CircleDecoration(color: ColorSchemeLight.instance.orange, radius: 3)),
      ),
      // initialRoute: NavigationConstants.HOME_VIEW,
      onGenerateRoute: NavigationRoute.instance.onGenerateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}
