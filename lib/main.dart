import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_furniture/core/components/decoration/circle_decoration.dart';
import 'package:my_furniture/core/constants/app/app_constants.dart';
import 'package:my_furniture/core/extension/context_extension.dart';
import 'package:my_furniture/core/init/cache/locale_manager.dart';
import 'package:my_furniture/core/init/lang/language_manager.dart';
import 'package:my_furniture/core/init/navigation/navigation_route.dart';
import 'package:my_furniture/core/init/navigation/navigation_serice.dart';
import 'package:my_furniture/core/init/theme/light/color_scheme_light.dart';
import 'package:my_furniture/view/furniture_tab_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  LocaleManager.instance;

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
        // for focus color change
        colorScheme: ThemeData().colorScheme.copyWith(primary: ColorSchemeLight.instance.darkGray),
        appBarTheme:
            const AppBarTheme(color: Colors.transparent, elevation: 0, systemOverlayStyle: SystemUiOverlayStyle.dark),
        tabBarTheme: TabBarTheme(
            labelColor: ColorSchemeLight.instance.orange,
            unselectedLabelColor: ColorSchemeLight.instance.darkGray,
            indicatorSize: TabBarIndicatorSize.label,
            // indicator: BoxDecoration(
            //   borderRadius: BorderRadius.circular(50),
            //   color: Colors.grey.shade200,
            // ),
            indicator: CircleDecoration(color: ColorSchemeLight.instance.orange, radius: 3)),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: ApplicationConstants.APP_PADDING,
            borderSide: BorderSide(color: ColorSchemeLight.instance.darkGray),
          ),
          outlineBorder: BorderSide(color: ColorSchemeLight.instance.darkGray),
        ),
        iconTheme: IconThemeData(
          color: ColorSchemeLight.instance.orange,
          size: context.mediumValue,
        ),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: ApplicationConstants.APP_PADDING,
          ),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: ApplicationConstants.APP_PADDING,
          ),
        ),
      ),
      // initialRoute: NavigationConstants.HOME_VIEW,
      onGenerateRoute: NavigationRoute.instance.onGenerateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
      debugShowCheckedModeBanner: false,
    );
  }
}
